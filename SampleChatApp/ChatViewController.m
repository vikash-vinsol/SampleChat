//
//  ChatViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 29/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL)animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    [self.chatTableView setContentInset:contentInsets];
    [self.chatTableView setScrollIndicatorInsets:contentInsets];
    
    CGRect messageFrame = self.footerView.frame;
    messageFrame.origin.y -= keyboardSize.height;
    [self.footerView setFrame:messageFrame];
}


- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [self.chatTableView setContentInset:UIEdgeInsetsZero];
    [UIView commitAnimations];
    [self.chatTableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    
    CGRect messageFrame = self.footerView.frame;
    messageFrame.origin.y += keyboardSize.height;
    [self.footerView setFrame:messageFrame];
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

- (IBAction)sendButtonAction:(id)sender
{
    [_messageTextField resignFirstResponder];
}
@end
