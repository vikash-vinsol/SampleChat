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

@interface GuestViewController ()

@end

@implementation GuestViewController

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _guest = [[Guest alloc] init];
    }
    return self;
}

-(Guest *)guest
{
    if (!_guest)
    {
        _guest = [[Guest alloc] init];
    }
    return _guest;
}

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenString = [defaults objectForKey:@"d_Token"];
    self.guest.email = _emailTextField.text;
    self.guest.password = _passwordTextField.text;
    NSDictionary *dictionary = @{@"email":self.guest.email, @"password":self.guest.password, @"device_token" : tokenString};
    return dictionary;
}

@end
