//
//  GuestViewController.h
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guest.h"
#import "Member.h"
#import "FriendsListTableViewController.h"

@interface GuestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) Guest *guest;
@property (nonatomic, strong) FriendsListTableViewController *friendController;

- (IBAction)submitButtonAction:(id)sender;


@end
