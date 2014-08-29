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

@interface GuestViewController ()

@end

@implementation GuestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.guest.email = _emailTextField.text;
    self.guest.password = _passwordTextField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenString    = [defaults objectForKey:@"d_Token"];
    
    NSDictionary *dictionary = @{@"email":self.guest.email, @"password":self.guest.password, @"device_token" : tokenString};
    
    NSString *hostString = [NSString stringWithFormat:@"%@/signin",Site_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hostString parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         
         self.member.name = self.guest.name;
         self.member.email= self.guest.email;
         
         _friendController = [[UIStoryboard storyboardWithName:@"Main"
                                                        bundle:NULL] instantiateViewControllerWithIdentifier:@"Friends_Controller"];
         
         [self openFriendsListViewController];

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)openFriendsListViewController
{
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:_friendController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
