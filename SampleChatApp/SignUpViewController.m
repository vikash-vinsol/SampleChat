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
#import "CoreDataHelper.h"


@interface SignUpViewController () <NSURLSessionDelegate>

@end

@implementation SignUpViewController


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
    
    
    NSManagedObjectContext *moc = [CoreDataHelper managedObjectContext];
    Guest *guest = [CoreDataHelper insertManagedObjectOfClass:[Guest class] inManagedObjectContext:moc];
    guest.email = _emailTextField.text;
    guest.password = _passwordTextField.text;
    guest.name = _nameTextField.text;

    
    NSDictionary *dictionary = @{@"name":guest.name, @"email":guest.email, @"password":guest.password, @"device_token" : tokenString};

    return dictionary;
}

@end
