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

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *receiverID;


@end
