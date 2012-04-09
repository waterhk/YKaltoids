//
//  YAConversationGapPlaceholderValidator.h
//  altoids
//
//  Created by Jon Herron on 9/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationValidator.h"
#import "ValidationErrorBuilder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationGapPlaceholderValidator : NSObject <ConversationValidator>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithValidationErrorBuilder:(id<ValidationErrorBuilder>)aValidationErrorBuilder;

@end
