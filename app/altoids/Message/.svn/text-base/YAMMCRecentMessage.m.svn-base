//
//  YAMMCRecentMessageFacade.m
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import "YAMMCRecentMessage.h"
#import "YAMMCParticipant.h"

#define kMessageIDKey @"mid"
#define kSubjectKey @"info.subj"
#define kSentKey @"info.date"
#define kRecipientsKey @"info.rcpts"
#define kSenderKey @"info.from.name"
#define kSnippetKey @"info.snippet"

// Private class extension
@interface YAMMCRecentMessage ()

// @property definitions
@property (copy,   nonatomic) NSDictionary *parsedRecentMessageResponse;

// methods

@end

@implementation YAMMCRecentMessage

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize parsedRecentMessageResponse = parsedRecentMessageResponse_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONRecentMessageResponse:(NSDictionary *)aParsedJSONRecentMessageResponse
{
  self = [super init];
    
  if (self) 
  {
      parsedRecentMessageResponse_ = [aParsedJSONRecentMessageResponse copy];
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

- (NSString *)messageID
{
    return [[self parsedRecentMessageResponse] objectForKey:kMessageIDKey];
}

- (NSString *)subject
{
    return [[self parsedRecentMessageResponse] valueForKeyPath:kSubjectKey];
}

- (NSDate *)sent
{
    return [NSDate dateWithTimeIntervalSince1970:[[[self parsedRecentMessageResponse] valueForKeyPath:kSentKey] doubleValue]];
}

- (NSString *)recipients
{
    return [[self parsedRecentMessageResponse] valueForKeyPath:kRecipientsKey];
}

- (NSString *)sender
{
    return [[self parsedRecentMessageResponse] valueForKeyPath:kSenderKey];
}

- (NSString *)snippet
{
    return [[self parsedRecentMessageResponse] valueForKeyPath:kSnippetKey];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCRecentMessageFacade ()

@end
