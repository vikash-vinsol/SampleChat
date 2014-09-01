//
//  ChatViewController.h
//  SampleChatApp
//
//  Created by Vikash Soni on 29/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
- (IBAction)sendButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) NSString *receiverID;
@property (weak, nonatomic) NSString *receiverName;

@end
