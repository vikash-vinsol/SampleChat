//
//  Message.h
//  SampleChatApp
//
//  Created by Vikash Soni on 27/08/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Message : NSObject
{
    
}

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) User *senderID;
@property (nonatomic, strong) User *receiverID;

@end
