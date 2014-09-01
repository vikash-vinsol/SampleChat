//
//  User.h
//  SampleChatApp
//
//  Created by Vikash Soni on 01/09/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *message;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessageObject:(Message *)value;
- (void)removeMessageObject:(Message *)value;
- (void)addMessage:(NSSet *)values;
- (void)removeMessage:(NSSet *)values;

@end
