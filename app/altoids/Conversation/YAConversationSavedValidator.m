//
//  YAConversationSavedValidator.m
//  altoids
//
//  Created by Jon Herron on 10/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationSavedValidator.h"

// Private class extension
@interface YAConversationSavedValidator ()

// @property definitions
@property (strong, nonatomic) id<ValidationErrorBuilder> validationErrorBuilder;

// methods

@end

@implementation YAConversationSavedValidator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize validationErrorBuilder = validationErrorBuilder_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithValidationErrorBuilder:(id<ValidationErrorBuilder>)theValidationErrorBuilder
{
  self = [super init];
    
  if (self) 
  {
      validationErrorBuilder_ = theValidationErrorBuilder;
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
#pragma mark ConversationValidator delegate methods

- (BOOL)conversationIsValid:(YAConversation *)aConversation error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    if (!aConversation) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationNilConversationErrorCode 
                                                                  message:kConversationValidationNilConversationErrorMsg];
        
        return NO;
    }
        
    if (![aConversation conversationID]) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationInvalidConversationID 
                                                                  message:kConversationValidationInvalidConversationID];
        
        return NO;
    }
    
    return YES;
}

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
#pragma mark YAConversationSavedValidator ()

@end
