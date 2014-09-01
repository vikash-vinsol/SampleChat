//
//  ChatViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 29/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "ChatViewController.h"
#import "Message.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "Member.h"

@interface ChatViewController ()
{
    NSString *senderName;
    Message *message;
    Member *member;
}

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
    
    member = [[Member alloc] init];
    
    self.navigationItem.title = _receiverName;
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Back" style: UIBarButtonItemStyleBordered
                                             target:self action:@selector(dismissMyView)];
    
    // Do any additional setup after loading the view.
}

- (void)dismissMyView {
    [self.navigationController popViewControllerAnimated:YES];
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

    [self.chatTableView scrollRectToVisible:CGRectMake(0, self.chatTableView.contentSize.height - self.chatTableView.bounds.size.height, self.chatTableView.bounds.size.width, self.chatTableView.bounds.size.height) animated:YES];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [self.chatTableView setContentInset:UIEdgeInsetsZero];
    [UIView commitAnimations];
    [self.chatTableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    
    CGRect messageFrame = self.footerView.frame;
    messageFrame.origin.y += keyboardSize.height;
    [self.footerView setFrame:messageFrame];
}

- (IBAction)sendButtonAction:(id)sender
{
    message = [[Message alloc] init];
    
    [_messageTextField resignFirstResponder];
    [self sendMessageToServer];
    _messageTextField.text  = @"";
}

-(void)sendMessageToServer

{
    NSString *hostString = [NSString stringWithFormat:@"%@/user/%@/send_message",Site_Url,message.senderID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hostString parameters:[self createParamsForServer] success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}


-(NSDictionary *)createParamsForServer
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    message.senderID = [defaults objectForKey:@"UserId"];
    message.receiverID = _receiverID;
    message.text = _messageTextField.text;

    [member.chatArray addObject:message];
    [self.chatTableView reloadData];
    
    NSLog(@"senderID %@",message.senderID);
    NSLog(@"receiverID %@",_receiverID);

    NSDictionary *hostDictionary = @{@"receiver_id" : message.receiverID, @"text" : message.text};
    return hostDictionary;
}

// Set Values when response return...!!!
-(void)getChatFromServer
{
    [member.chatArray addObject:message];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [member.chatArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    Message *chat = [member.chatArray objectAtIndex:indexPath.row];
    cell.textLabel.text = chat.text;
    return cell;
}

@end
