//
//  YAConversationGapPlaceholderValidator.m
//  altoids
//
//  Created by Jon Herron on 9/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationGapPlaceholderValidator.h"
#import "ConversationStatus.h"

// Private class extension
@interface YAConversationGapPlaceholderValidator ()

// @property definitions
@property (strong, nonatomic) id<ValidationErrorBuilder> validationErrorBuilder;

// methods

@end

@implementation YAConversationGapPlaceholderValidator

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

- (id)initWithValidationErrorBuilder:(id<ValidationErrorBuilder>)aValidationErrorBuilder
{
  self = [super init];
    
  if (self) 
  {
      validationErrorBuilder_ = aValidationErrorBuilder;
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
    
    BOOL isValid = NO;
    
    if (!(isValid = [[aConversation status] intValue] == YAConversationStatusGapPlaceholder))
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationInvalidGapPlaceholderConversationErrorCode message:kConversationValidationInvalidGapPlaceholderConversationErrorMsg];
    }
    
    return isValid;
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
#pragma mark YAConversationGapPlaceholderValidator ()

@end
