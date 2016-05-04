/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Displays the application window.
 */

#import "AppDelegate.h"
#import <CloudKit/CloudKit.h>

@implementation AppDelegate

- (void)application:(__unused UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error
{
    NSLog(@"Error registering for push notification %@", error.description);
}

/*
- (void)application:(__unused UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
}
*/

- (void)application:(__unused UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Received push notification");
    CKNotification *ckNotification = [CKNotification notificationFromRemoteNotificationDictionary:userInfo];
    if (ckNotification.notificationType == CKNotificationTypeQuery) {
        CKQueryNotification *queryNotification = (CKQueryNotification*)ckNotification;
        CKRecordID *recordID = [queryNotification recordID];
        NSLog(@"Push: %@", recordID.recordName);
        // ...
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(__unused NSDictionary *)launchOptions
{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings 
        settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) 
              categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];

    return YES;
}

@end
