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
#import "ChatViewController.h"

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
    NSString *tokenString = [self deviceToken:deviceToken];
    [defaults setObject:tokenString forKey:@"d_Token"];
    [defaults synchronize];

}


-(NSString *) deviceToken : (NSData *)data
{
    NSString *tokenString = [[[data description]
                              stringByReplacingOccurrencesOfString:@"<"withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Token String %@",tokenString);
    
    return tokenString;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Sender ID: %@",[[userInfo valueForKey:@"aps"] valueForKey:@"sender_id"]);
    NSLog(@"Alert message: %@",[userInfo valueForKey:@"message"]);
    NSLog(@"User Name : %@",[userInfo valueForKey:@"user_name"]);
    
    [PFPush handlePush:userInfo];
    if (application.applicationState == UIApplicationStateActive )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bildirim"
                                                            message:[NSString stringWithFormat:@"%@ ",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]]
                                                           delegate:self cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    else
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];

        ChatViewController *mainViewController = (ChatViewController*)[mainStoryboard
                                                                           instantiateViewControllerWithIdentifier: @"ChatVC"];
        
        [mainViewController setReceiverName : @"abd"];
        [mainViewController setReceiverID: @"4"];

        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.window setRootViewController:navigationController];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        [self.window makeKeyAndVisible];
    }
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
