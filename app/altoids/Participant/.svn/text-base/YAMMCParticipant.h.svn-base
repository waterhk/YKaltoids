//
//  YAMMCParticipantFacade.h
//  altoids
//
//  Created by Jon Herron on 9/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <Foundation/Foundation.h>

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCParticipant : NSObject

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithParsedJSONParticipantResponse:(NSDictionary *)aParsedJSONParticipentResponse;

- (NSString *)transientID;
- (NSString *)participantID;
- (NSString *)firstName;
- (NSString *)lastName;
- (NSString *)imageURL;
- (NSDate *)created;
- (NSString *)address;
- (NSString *)addressType;
- (BOOL)isConversationCreator;
- (BOOL)isUser;

@end
