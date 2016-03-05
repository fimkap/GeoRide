//
//  NearbyPlaces.h
//  CurrentAddress
//
//  Created by Efim Polevoi on 26/02/2016.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface NearbyPlaces : NSObject

-(id)init;
-(void)arrayOfPlaces:(MKMapView*)mapView withCompletionHandler:(void(^)(NSArray*, NSError*))handler;

@end
