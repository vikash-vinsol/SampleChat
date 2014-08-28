//
//  SignUpViewController.h
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guest.h"
#import "Member.h"
#import "FriendsListTableViewController.h"

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) Guest *guest;
@property (strong, nonatomic) Member *member;
@property (strong, nonatomic)FriendsListTableViewController *friendController;

@end
