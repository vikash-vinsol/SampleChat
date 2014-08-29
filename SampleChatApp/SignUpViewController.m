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

-(Member *)member
{
    if (!_member)
    {
        _member = [[Member alloc] init];
    }
    return _member;
}

-(void)viewDidLoad
{
    _passwordTextField.delegate  = self;
}

- (IBAction)submitGuestDetails:(id)sender
{
    [self.passwordTextField resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenString = [defaults objectForKey:@"d_Token"];
    
    self.guest.name = _nameTextField.text;
    self.guest.email = _emailTextField.text;
    self.guest.password = _passwordTextField.text;
    
    NSDictionary *dictionary = @{@"name":self.guest.name, @"email":self.guest.email, @"password":self.guest.password, @"device_token" : tokenString};
    
    NSString *hostString = [NSString stringWithFormat:@"%@/users/register",Site_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hostString parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSLog(@"JSON: %@", responseObject);
         [self convertGuestToMember];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}


-(NSURL *)generateHostUrl
{
    NSString *hostString = [NSString stringWithFormat:@"%@/users/register",Site_Url];
    NSURL *url = [NSURL URLWithString:hostString];
    
    NSLog(@"URL %@",url);

    return url;
}

-(void)convertGuestToMember
{
    self.member.name = self.guest.name;
    self.member.email= self.guest.email;
    
    _friendController = [[UIStoryboard storyboardWithName:@"Main"
                                                        bundle:NULL]instantiateViewControllerWithIdentifier:@"Friends_Controller"];
    
    [self openFriendsListViewController];
}

-(void)openFriendsListViewController
{
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:_friendController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
