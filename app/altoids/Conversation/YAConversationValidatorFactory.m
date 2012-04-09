//
//  YAConversationValidatorFactory.m
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationValidatorFactory.h"
#import "ConversationStatus.h"
#import "ConversationValidator.h"
#import "YAConversation.h"
#import "YAConversationDraftValidator.h"
#import "YAConversationPendingValidator.h"
#import "YAConversationSavedValidator.h"
#import "YAConversationGapPlaceholderValidator.h"

// Private class extension
@interface YAConversationValidatorFactory ()

// @property definitions

// methods

@end

@implementation YAConversationValidatorFactory

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

- (id<ConversationValidator>)createValidatorForConversation:(YAConversation *)aConversation
{
    id<ConversationValidator> validator = nil;
    
    if (!aConversation) 
    {
        return nil;
    }
    
    switch ([[aConversation status] intValue]) {
        case YAConversationStatusNew:
        case YAConversationStatusDraft:
            validator = [[YAConversationDraftValidator alloc] initWithValidationErrorBuilder:[self validationErrorBuilder]];
            break;
        case YAConversationStatusPending:
        case YAConversationStatusPendingWithErrors:
            validator = [[YAConversationPendingValidator alloc] initWithValidationErrorBuilder:[self validationErrorBuilder]];
            break;
        case YAConversationStatusSaved:
            validator = [[YAConversationSavedValidator alloc] initWithValidationErrorBuilder:[self validationErrorBuilder]];
            break;
        case YAConversationStatusGapPlaceholder:
            validator = [[YAConversationGapPlaceholderValidator alloc] initWithValidationErrorBuilder:[self validationErrorBuilder]];
            break;
        default:
            break;
    }
    
    return validator;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationValidatorFactory ()

@end
