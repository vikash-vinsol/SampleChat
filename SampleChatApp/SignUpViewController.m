//
//  SignUpViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "SignUpViewController.h"
#import "Constant.h"
#import "AFNetworking.h"
#import "UIViewController+OpenFriendsList.h"


@interface SignUpViewController () <NSURLSessionDelegate>

@end

@implementation SignUpViewController

-(Guest *)guest
{
    if (!_guest)
    {
        _guest = [[Guest alloc] init];
    }
    
    return _guest;
}

-(void)viewDidLoad
{
    _passwordTextField.delegate  = self;
}

- (IBAction)submitGuestDetails:(id)sender
{
    [self.passwordTextField resignFirstResponder];
    
    NSString *hostString = [NSString stringWithFormat:@"%@/users/register",Site_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hostString parameters:[self createParamsForServer] success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSLog(@"JSON: %@", responseObject);
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
    
    self.guest.name = _nameTextField.text;
    self.guest.email = _emailTextField.text;
    self.guest.password = _passwordTextField.text;
    
    NSDictionary *dictionary = @{@"name":self.guest.name, @"email":self.guest.email, @"password":self.guest.password, @"device_token" : tokenString};

    return dictionary;
}

@end
