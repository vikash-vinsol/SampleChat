//
//  User.m
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)init
{
    self = [super init];
    
    if ( self)
    {
        
    }
    
    return self;
}

-(NSString *)deviceToken
{
    if (!_deviceToken)
    {
        _deviceToken = [[NSString alloc] init];
    }
    return _deviceToken;
}

@end
