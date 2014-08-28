//
//  User.h
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}

@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * deviceToken;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString *password;

@end
