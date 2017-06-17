//
//  RideDataManager.m
//  CurrentAddress
//
//  Created by Efim Polevoi on 29/04/2016.
//
//

#import "RideDataManager.h"
#import "Geo_Ride-Swift.h"

@interface RideDataManager ()
@property (nonatomic,strong) CKDatabase *publicDB;
@property (nonatomic,strong) CKRecordID *userRecID;
@end

@implementation RideDataManager

- (id)init
{
    self = [super init];
    if (self) {
        _publicDB = [[CKContainer defaultContainer] publicCloudDatabase];
    }
    return self;
}

- (void)initUserID
{
  //__weak RideDataManager* welf = self;
  [[CKContainer defaultContainer] fetchUserRecordIDWithCompletionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error){
    if (!error) {
      self.userRecID = recordID;
      NSLog(@"Read User Record ID. Record Name: %@", recordID.recordName);
      [self fetchUserInfo:recordID];
    }
    else
      NSLog(@"Error fetching user record ID %@", error.description);
  }];
}

- (void)fetchUserInfo:(CKRecordID*)recordID
{
  [[CKContainer defaultContainer] discoverUserIdentityWithUserRecordID:recordID completionHandler:^(CKUserIdentity * _Nullable userInfo, NSError * _Nullable error) {
    NSLog(@"%@,%@", userInfo.nameComponents.givenName, userInfo.nameComponents.familyName);
    User.testUser.name = userInfo.nameComponents.givenName;
  }];
}

- (void)storeLocation:(CLLocationCoordinate2D)destination riderName:(NSString*)name
{
    [self setUserDestination:destination]; // Save locally

    NSString *recName = [NSString stringWithFormat:@"GreatRoute%@", self.userRecID.recordName];
    //NSString *recName = [NSString stringWithFormat:@"GreatRoute_%@", name];
    CKRecordID *greatID = [[CKRecordID alloc] initWithRecordName:recName];

    [self.publicDB fetchRecordWithID:greatID completionHandler:^(CKRecord *fetchedRoute, NSError *error) {
        if (error)
            NSLog(@"Error fetching record %@", error.description);
        if (fetchedRoute) {
            fetchedRoute[@"Destination"] = [[CLLocation alloc] initWithLatitude:destination.latitude longitude:destination.longitude];
            [self.publicDB saveRecord:fetchedRoute completionHandler:^(CKRecord *savedPlace, NSError *savedError) {
                if (savedError)
                    NSLog(@"Error editing record %@", savedError.description);
                else {
                    NSLog(@"Edited record %@", savedPlace[@"Name"]);
                    [self subscribeToNotificationOnRiders:destination];
                }
            }];
        } else {
            CKRecord *place = [[CKRecord alloc] initWithRecordType:@"Route" recordID:greatID];
            place[@"Name"] = [[NSString alloc] initWithString:name];
            place[@"Destination"] = [[CLLocation alloc] initWithLatitude:destination.latitude longitude:destination.longitude];
            //place[@"Source"] = destination;
            [self.publicDB saveRecord:place completionHandler:^(CKRecord *savedPlace, NSError *savedError) {
                // handle errors here
                if (savedError)
                    NSLog(@"Error saving record %@", savedError.description);
                else {
                    NSLog(@"Saved record %@", savedPlace[@"Name"]);
                    [self subscribeToNotificationOnRiders:destination];
                }
            }];
        }
    }];
}

- (void)subscribeToNotificationOnRiders:(CLLocationCoordinate2D)destination
{
    CLLocation *fixedLoc = [[CLLocation alloc] initWithLatitude:destination.latitude longitude:destination.longitude];
    CGFloat radius = 5000; // meters
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"distanceToLocation:fromLocation:(Destination, %@) < %f", fixedLoc, radius];

    CKSubscription *subscription = [[CKSubscription alloc] initWithRecordType:@"Route" predicate:predicate options:CKSubscriptionOptionsFiresOnRecordCreation];

    CKNotificationInfo *info = [CKNotificationInfo new];
    //info.alertLocalizationKey = @"NEW_RIDER_ALERT_KEY";
    info.alertBody = @"New rider arrived!";
    info.soundName = @"Announce.aiff";
    info.shouldBadge = YES;

    subscription.notificationInfo = info;

    [self.publicDB saveSubscription:subscription
                  completionHandler:^(CKSubscription *savedSubscription, NSError *error) {
                      if (error)
                          NSLog(@"Error in subscription %@", error.description);
                      else
                          NSLog(@"Saved subscription: ID [%@]", savedSubscription.subscriptionID);
             }];
}

- (void)ridersToDestination:(CLLocationCoordinate2D)destination withCompletionHandler:(void(^)(NSArray*, NSError*))handler
{
    CLLocation *fixedLoc = [[CLLocation alloc] initWithLatitude:destination.latitude longitude:destination.longitude];
    CGFloat radius = 5000; // meters
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"distanceToLocation:fromLocation:(Destination, %@) < %f", fixedLoc, radius];

    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Route" predicate:predicate];
    [self.publicDB performQuery:query 
                   inZoneWithID:nil 
              completionHandler:^(NSArray *results, NSError *error){
                  handler(results, error);
              }];
}

@end
