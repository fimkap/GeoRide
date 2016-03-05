//
//  NearbyPlaces.m
//  CurrentAddress
//
//  Created by Efim Polevoi on 26/02/2016.
//
//

#import "NearbyPlaces.h"

@interface NearbyPlaces ()
@property (nonatomic,strong) NSMutableArray* places;
@end

@implementation NearbyPlaces

-(id)init
{
    self = [super init];
    if (self) {
        _places = [NSMutableArray arrayWithCapacity:1];
    }

    return self;
}

-(void)arrayOfPlaces:(MKMapView*)mapView withCompletionHandler:(void(^)(NSArray*, NSError*))handler
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"Hotels";
    request.region = mapView.region;

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSLog(@"Map Items: %@", response.mapItems);
        [self.places setArray:response.mapItems];
        handler(response.mapItems, error);
    }];
}

@end
