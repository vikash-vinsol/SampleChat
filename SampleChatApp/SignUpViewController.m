//
//  SignUpViewController.m
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "SignUpViewController.h"
#import "Constant.h"


@interface SignUpViewController ()

@end

@implementation SignUpViewController
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}


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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitGuestDetails:(id)sender
{
    self.guest.name = _nameTextField.text;
    self.guest.email = _emailTextField.text;
    self.guest.password = _passwordTextField.text;
    
    
    NSDictionary *dictionary = @{@"name":self.guest.name, @"email":self.guest.email, @"Password":self.guest.password};
    
    NSLog(@"Send Dictionary %@",dictionary);

    [self sendGuestDetailsToServer:dictionary];
}

-(void)sendGuestDetailsToServer : (NSDictionary *)dictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenString = [self deviceToken:[defaults objectForKey:@"d_Token"]];

    NSString *hostString = [NSString stringWithFormat:@"%@?devicetoken=%@",Site_Url,tokenString];
    NSURL *url = [NSURL URLWithString:hostString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSDictionary *postDictionary = dictionary;
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:postDictionary
                                                   options:kNilOptions error:&error];
    
    if (!error)
    {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error)
                                              {
                                                  
                                                  NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"Data = %@",text);
                                                  NSLog(@"Updated Successfully");
                                                  
                                                  [self convertGuestToMember];
                                              }];
        
        [uploadTask resume];
    }
    
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Wrong email" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
        
        [errorAlert show];
    }

}

-(void)convertGuestToMember
{
    self.member.name = self.guest.name;
    self.member.email= self.guest.email;
    
    _friendController = [[UIStoryboard storyboardWithName:@"Main"
                                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"Friends_Controller"];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:_friendController];
   
    [self presentViewController:navigationController animated:YES completion:nil];
}


-(NSString *)deviceToken : (NSData *)data
{
    NSString *tokenString = [[[[data description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];

    return tokenString;
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
