//
//  FriendsListTableViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 28/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "FriendsListTableViewController.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "ChatViewController.h"

@interface FriendsListTableViewController ()
{
    NSMutableArray *friendsArray;
}

@end

@implementation FriendsListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self getListOfFriendsFromServer];
}

-(void)getListOfFriendsFromServer
{
    NSString *hostString = [NSString stringWithFormat:@"%@/users",Site_Url];
    NSURL *URL = [NSURL URLWithString:hostString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         friendsArray = [responseObject objectForKey:@"users"];
         NSLog(@"JSON: %@", friendsArray);
         [self.tableView reloadData];
         
     }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    cell.textLabel.text = [[friendsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path =  [self.tableView indexPathForCell:(UITableViewCell*)sender];

    if ([[segue identifier] isEqualToString:@"FriendChat"])
    {
        ChatViewController *chatViewController = [segue destinationViewController];
        [chatViewController setReceiverName : [[friendsArray objectAtIndex:path.row] objectForKey:@"name"]];
        [chatViewController setReceiverID: [[friendsArray objectAtIndex:path.row] objectForKey:@"id"]];
    }
}

@end
