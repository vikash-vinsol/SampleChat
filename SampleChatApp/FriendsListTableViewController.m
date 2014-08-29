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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setSeparatorInset:UIEdgeInsetsZero];

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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FontCell" forIndexPath:indexPath];
    cell.textLabel.text = [[friendsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"FriendChat"])
    {
        // Get reference to the destination view controller
        ChatViewController *chatViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [chatViewController friendName:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row); // you can see selected row number in your console;
}

@end
