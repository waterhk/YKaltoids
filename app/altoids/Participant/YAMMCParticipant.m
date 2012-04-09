//
//  YAMMCParticipantFacade.m
//  altoids
//
//  Created by Jon Herron on 9/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import "YAMMCParticipant.h"

#define kTransientIDKey @"id"
#define kParticipantIDKey @"pid"
#define kFirstNameKey @"firstname"
#define kLastNameKey @"lastname"
#define kImageURLKey @"imageURL"
#define kCreatedKey @"created"
#define kAddressKey @"address"
#define kAddressTypeKey @"addressType"
#define kIsConversationCreatorKey @"creator"
#define kIsUserKey @"isYou"

// Private class extension
@interface YAMMCParticipant ()

// @property definitions
@property (copy, nonatomic) NSDictionary *parsedJSONParticipantResponse;

// methods

@end

@implementation YAMMCParticipant

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize parsedJSONParticipantResponse = parsedJSONParticipantResponse_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONParticipantResponse:(NSDictionary *)aParsedJSONParticipentResponse
{
  self = [super init];
    
  if (self) 
  {
      parsedJSONParticipantResponse_ = [aParsedJSONParticipentResponse copy];
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (NSString *)transientID
{
    return [[self parsedJSONParticipantResponse] objectForKey:kTransientIDKey];
}

- (NSString *)participantID
{
    return [[self parsedJSONParticipantResponse] objectForKey:kParticipantIDKey];
}

- (NSString *)firstName
{
    return [[self parsedJSONParticipantResponse] objectForKey:kFirstNameKey];
}

- (NSString *)lastName
{
    return [[self parsedJSONParticipantResponse] objectForKey:kLastNameKey];
}

- (NSString *)imageURL
{
    return [[self parsedJSONParticipantResponse] objectForKey:kImageURLKey];    
}

- (NSDate *)created
{
    return [NSDate dateWithTimeIntervalSince1970:[[[self parsedJSONParticipantResponse] objectForKey:kCreatedKey] doubleValue]];
}

- (NSString *)address
{
    return [[self parsedJSONParticipantResponse] objectForKey:kAddressKey];
}

- (NSString *)addressType
{
    return [[self parsedJSONParticipantResponse] objectForKey:kAddressTypeKey];
}

- (BOOL)isConversationCreator
{
    return [[[self parsedJSONParticipantResponse] objectForKey:kIsConversationCreatorKey] boolValue];
}

- (BOOL)isUser
{
    return [[[self parsedJSONParticipantResponse] objectForKey:kIsUserKey] boolValue];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCParticipantFacade ()

@end
