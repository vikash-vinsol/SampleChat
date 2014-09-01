//
//  Message.h
//  SampleChatApp
//
//  Created by Vikash Soni on 01/09/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * senderId;
@property (nonatomic, retain) NSString * receiverId;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) User *user;

@end
