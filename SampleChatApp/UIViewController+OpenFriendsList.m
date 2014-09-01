//
//  UIViewController+OpenFriendsList.m
//  SampleChatApp
//
//  Created by Vikash Soni on 29/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "UIViewController+OpenFriendsList.h"
#import "FriendsListTableViewController.h"

@implementation UIViewController (OpenFriendsList)

-(void)openFriendsListViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    FriendsListTableViewController *friendController  = [storyboard instantiateViewControllerWithIdentifier:@"Friends_Controller"];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:friendController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)generateUserData : (id) response
{
    NSString *name = [[response objectForKey:@"user_info"] objectForKey:@"name"];

    NSString *uid = [[response objectForKey:@"user_info"] objectForKey:@"id"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:name forKey:@"UserName"];
    [defaults setObject:uid forKey:@"UserId"];
    
    [defaults synchronize];
}

@end
