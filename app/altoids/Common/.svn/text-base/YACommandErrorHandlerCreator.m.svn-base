//
//  YACommandErrorHandlerCreator.m
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACommandErrorHandlerCreator.h"
#import "YACommandErrorHandler.h"

// Private class extension
@interface YACommandErrorHandlerCreator ()

// @property definitions

// methods

@end

@implementation YACommandErrorHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize commandErrorCreator = commandErrorCreator_;

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
#pragma mark CommandErrorHandlerCreator delegate methods

- (id<CommandErrorHandler>)createWithErrorHandler:(id<ErrorHandler>)theErrorHandler
{
    return [[YACommandErrorHandler alloc] initWithErrorHandler:theErrorHandler 
                                           commandErrorCreator:[self commandErrorCreator]];
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
#pragma mark YACommandErrorHandlerCreator ()

@end
