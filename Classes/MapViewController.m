/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Controls the map view and manages the reverse geocoder to get the current address.
 */

#import "MapViewController.h"
#import "PlacemarkViewController.h"
#import "MKMapView+ZoomLevel.h"
#import "NearbyPlaces.h"
#import "UIImage+Color.h"
#import "RideDataManager.h"
#import <CloudKit/CloudKit.h>

#define MAX_NUM_PLACES 4

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *getAddressButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKPlacemark *placemark;
@property (nonatomic, strong) NearbyPlaces *nearbyPlaces;
@property (nonatomic, strong) NSMutableDictionary *nearbyPlacesLocationMap;

@property (nonatomic,strong) RideDataManager *rideDataManager;
@property (nonatomic,copy) NSString *riderName;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    // Gets user permission use location while the app is in the foreground.
    [self.locationManager requestWhenInUseAuthorization];

    self.geocoder = [[CLGeocoder alloc] init];
    
    self.nearbyPlaces = [[NearbyPlaces alloc] init];
    self.nearbyPlacesLocationMap = [[NSMutableDictionary alloc] init];

    self.rideDataManager = [[RideDataManager alloc] init];
    [self.rideDataManager initUserID];

    [[UIToolbar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[[UIBarButtonItem appearance] setTintColor:nil];

    [self saveRiderName];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(__unused id)sender
{
    if ([segue.identifier isEqualToString:@"pushToDetail"])
    {
		// Get the destination view controller and set the placemark data that it should display.
        PlacemarkViewController *viewController = segue.destinationViewController;
        viewController.placemark = self.placemark;
    }
}

- (IBAction)selectDestination:(__unused id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Destination" message:@"Select destination" preferredStyle:UIAlertControllerStyleActionSheet];
    //NSArray *places = [NSArray arrayWithObjects:@"Fuengirola", @"Benalmadena", @"Torremolinos", nil];
    [self.nearbyPlaces arrayOfPlaces:self.mapView withCompletionHandler:^(NSArray *places, __unused NSError *error) {
        NSMutableArray *mutablePlaces = [places mutableCopy];
        if (mutablePlaces.count > MAX_NUM_PLACES) {
            NSRange r;
            r.location = MAX_NUM_PLACES;
            r.length = mutablePlaces.count - MAX_NUM_PLACES;
            [mutablePlaces removeObjectsInRange:r];
        }
        for (MKMapItem *place in mutablePlaces)
        {
            [self.nearbyPlacesLocationMap setObject:place.placemark forKey:place.name];
            [alert addAction:[UIAlertAction actionWithTitle:place.name
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        MKPlacemark *pmark = [self.nearbyPlacesLocationMap objectForKey:action.title];
                                                        NSLog(@"Location of destination [%f][%f]", pmark.coordinate.latitude, pmark.coordinate.longitude);
                                                        [self.rideDataManager storeLocation:pmark.coordinate riderName:self.riderName];
                                                        }]];
        }

        [alert addAction:[UIAlertAction actionWithTitle:@"Other Destination"
                   style:UIAlertActionStyleDefault
                 handler:^(__unused UIAlertAction *action) {
                     NSLog(@"handler");
                 }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                   style:UIAlertActionStyleDefault
                 handler:^(__unused UIAlertAction *action) {
                     NSLog(@"handler");
                 }]];

        [self presentViewController:alert animated:YES completion:nil];
    }];

}

- (void)mapView:(__unused MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	// Center the map the first time we get a real location change.
	static dispatch_once_t centerMapFirstTime;

	if ((userLocation.coordinate.latitude != 0.0) && (userLocation.coordinate.longitude != 0.0)) {
		dispatch_once(&centerMapFirstTime, ^{
            [self.mapView setCenterCoordinate:userLocation.coordinate zoomLevel:10 animated:YES];
		});
	}
	
	// Lookup the information for the current location of the user.
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, __unused NSError *error) {
		if ((placemarks != nil) && (placemarks.count > 0)) {
			// If the placemark is not nil then we have at least one placemark. Typically there will only be one.
			self.placemark = placemarks[0];
			
			// we have received our current location, so enable the "Get Current Address" button
            self.getAddressButton.enabled = YES;
		}
		else {
			// Handle the nil case if necessary.
		}
    }];
}

- (void)mapView:(__unused MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{

    self.getAddressButton.enabled = NO;
    
    if (!self.presentedViewController) {
        NSString *message = nil;
        if (error.code == kCLErrorLocationUnknown) {            
            // If you receive this error while using the iOS Simulator, location simulatiion may not be on.  Choose a location from the Debug > Simulate Location menu in Xcode.
            message = @"Your location could not be determined.";
        }
        else {
            message = error.localizedDescription;
        }
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)locationManager:(__unused CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location Disabled"
                                                                       message:@"Please enable location services in the Settings app."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // This will implicitly try to get the user's location, so this can't be set
        // until we know the user granted this app location access
        self.mapView.showsUserLocation = YES;
    }
}

- (void)saveRiderName
{
    self.riderName = [[NSUserDefaults standardUserDefaults] objectForKey:@"RiderName"];
    if (self.riderName)
        return;

    // Save to user defaults on the first run
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Rider Name" 
                                                                   message:@"Enter your name" 
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
               style:UIAlertActionStyleDefault
             handler:nil]];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        self.riderName = textField.text;
        [[NSUserDefaults standardUserDefaults] setObject:self.riderName forKey:@"RiderName"]; 
        }];

    [self presentViewController:alert animated:YES completion:nil];
}

@end
