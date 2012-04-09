//
//  ConversationFlagMessagesRequestDataBuilder.h
//  altoids
//
//  Created by Anand Biligiri on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConversationFlagMessagesRequestDataBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSDictionary *)requestDataToFlagMessagesAsRead:(NSArray *)messageIDs;
- (NSDictionary *)requestDataToFlagMessagesAsUnRead:(NSArray *)messageIDs;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
