//
//  YAConversationPendingValidator.m
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationPendingValidator.h"

// Private class extension
@interface YAConversationPendingValidator ()

// @property definitions
@property (strong, readwrite, nonatomic) id<ValidationErrorBuilder> validationErrorBuilder;

// methods

@end

@implementation YAConversationPendingValidator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithValidationErrorBuilder:(id<ValidationErrorBuilder>)aValidationErrorBuilder
{
    self = [super init];
    
    if (self) 
    {
        [self setValidationErrorBuilder:aValidationErrorBuilder];
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize validationErrorBuilder;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (BOOL)conversationIsValid:(YAConversation *)aConversation error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    if (!aConversation) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationNilConversationErrorCode 
                                                                  message:kConversationValidationNilConversationErrorMsg];
        
        return NO;
    }
    
    if (![aConversation conversationContext]) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationNilContextErrorCode 
                                                                  message:kConversationValidationNilContextErrorMsg];
        
        return NO;
    }
    
    if (![aConversation sender]) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationNilSenderErrorCode 
                                                                  message:kConversationValidationNilSenderErrorMsg];
        
        return NO;
    }

    if ([[aConversation messages] count] < 1) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationTooFewMessagesErrorCode
                                                                  message:kConversationValidationTooFewMessagesErrorMsg];
        
        return NO;
    }
    
    if ([[aConversation participants] count] < 1) 
    {
        *anError = [[self validationErrorBuilder] validationErrorWithCode:YAConversationValidationTooFewParticipantsErrorCode
                                                                  message:kConversationValidationTooFewParticipantsErrorMsg];
        
        return NO;
    }
    
    return YES;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationPendingValidator ()

@end
