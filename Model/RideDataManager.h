//
//  RideDataManager.h
//  CurrentAddress
//
//  Created by Efim Polevoi on 29/04/2016.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CloudKit/CloudKit.h>

@interface RideDataManager : NSObject

- (void)initUserID;
- (void)storeLocation:(CLLocationCoordinate2D)destination;
- (void)subscribeToNotificationOnRiders:(CLLocationCoordinate2D)destination;

@end
