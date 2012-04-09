//
//  YAParticipantInfo.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressInfo.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAParticipantInfo : NSObject

#pragma mark @property declarations
@property (copy,   nonatomic, readonly) NSString *participantID;
@property (copy,   nonatomic, readonly) NSString *firstName;
@property (copy,   nonatomic, readonly) NSString *lastName;
@property (copy,   nonatomic, readonly) NSString *imageURL;
@property (strong, nonatomic, readonly) YAAddressInfo *addressInfo;
@property (assign, nonatomic, readonly) BOOL isContact;
@property (copy,   nonatomic, readonly) NSDate *timestamp;
@property (assign, nonatomic, readonly) BOOL isConversationCreator;
@property (assign, nonatomic, readonly) BOOL isUser;
@property (copy,   nonatomic, readonly) NSString *transientID;

#pragma mark  Class methods

+ (id)participantInfoWithFirstName:(NSString *)aFirstName 
                          lastName:(NSString *)aLastName 
                       addressInfo:(YAAddressInfo *)anAddress;

+ (id)participantInfoWithFirstName:(NSString *)aFirstName 
                          lastName:(NSString *)aLastName 
                       addressInfo:(YAAddressInfo *)anAddress 
                         isContact:(BOOL)aIsContact;

#pragma mark Instance methods

- (id)initWithParticipantID:(NSString *)aParticipantID
                  firstName:(NSString *)aFirstName
                   lastName:(NSString *)aLastName
                   imageURL:(NSString *)theImageURL
                addressInfo:(YAAddressInfo *)anAddress
                  isContact:(BOOL)anIsContact
                  timestamp:(NSDate *)aTimestamp
      isConversationCreator:(BOOL)anIsConversationCreator
                     isUser:(BOOL)anIsUser
                transientID:(NSString *)aTransientID;

@end
