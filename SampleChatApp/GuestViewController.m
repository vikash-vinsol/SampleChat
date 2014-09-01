//
//  GuestViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "GuestViewController.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "UIViewController+OpenFriendsList.h"
#import "CoreDataHelper.h"

@interface GuestViewController ()

@end

@implementation GuestViewController



- (IBAction)submitButtonAction:(id)sender
{
    NSDictionary *dictionary = [self createParamsForServer];
    NSString *hostString = [NSString stringWithFormat:@"%@/signin", Site_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hostString parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
     {         
         [self generateUserData:responseObject];
         [self openFriendsListViewController];

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(NSDictionary *)createParamsForServer
{
    NSManagedObjectContext *moc = [CoreDataHelper managedObjectContext];
    Guest *guest = [CoreDataHelper insertManagedObjectOfClass:[Guest class] inManagedObjectContext:moc];
    guest.email = _emailTextField.text;
    guest.password = _passwordTextField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenString = [defaults objectForKey:@"d_Token"];
    
    NSDictionary *dictionary = @{@"email":guest.email, @"password":guest.password, @"device_token" : tokenString};
    
    return dictionary;
}

@end
