//
//  YAMessage.h
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YAConversation, YAParticipant;

@interface YAMessage : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * messageID;
@property (nonatomic, retain) NSNumber * read;
@property (nonatomic, retain) NSString * snippet;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) YAConversation *conversation;
@property (nonatomic, retain) YAConversation *mostRecentForConversation;
@property (nonatomic, retain) YAParticipant *sender;

- (CGFloat)heightWithFont:(UIFont *)aFont width:(CGFloat)aWidth;

@end
