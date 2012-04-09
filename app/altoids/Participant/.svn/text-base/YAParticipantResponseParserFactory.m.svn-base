//
//  YAParticipantResponseParserFactory.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantResponseParserFactory.h"
#import <SBJson/SBJson.h>
#import "YAValidateParticipantResponse.h"

// Private class extension
@interface YAParticipantResponseParserFactory ()

// @property definitions

// methods

@end

@implementation YAParticipantResponseParserFactory

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides
- (YAValidateParticipantResponse *)parseValidateParticipantResponse:(NSData *)response error:(NSError *)error
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    YAValidateParticipantResponse *participantResponse = [[YAValidateParticipantResponse alloc] init];
    [participantResponse setBody:[parser objectWithData:response]];
    
    return participantResponse;
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAParticipantResponseParserFactory ()

@end
