//
//  AppDelegate.m
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Message.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
      
    [Parse setApplicationId:@"l5cyLxDSW7Wpz2ETMYCq0kJV1ZHXqRBwywVXxGYR" clientKey:@"pIwVKWjRegT1kx5QpTtdTlhm9VVII4RF9pBAhNBh"];

    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeSound|
                                                    UIRemoteNotificationTypeAlert];
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:deviceToken forKey:@"d_Token"];
    [defaults synchronize];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"Sender ID: %@",[[userInfo valueForKey:@"aps"] valueForKey:@"sender_id"]);
    NSLog(@"Alert message: %@",[userInfo valueForKey:@"message"]);
    NSLog(@"User Name : %@",[userInfo valueForKey:@"user_name"]);

    [PFPush handlePush:userInfo];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    if (currentInstallation.badge != 0)
    {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
