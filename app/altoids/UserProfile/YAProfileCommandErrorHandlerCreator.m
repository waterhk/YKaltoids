//
//  YAProfileCommandErrorHandlerCreator.m
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAProfileCommandErrorHandlerCreator.h"
#import "YAProfileCommandErrorHandler.h"

// Private class extension
@interface YAProfileCommandErrorHandlerCreator ()

// @property definitions

// methods

@end

@implementation YAProfileCommandErrorHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileErrorCreator = profileErrorCreator_;

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
#pragma mark CommandErrorHandlerCreator methods
- (id<CommandErrorHandler>)createWithErrorHandler:(id<ErrorHandler>)theErrorHandler
{
    return [[YAProfileCommandErrorHandler alloc] initWithErrorHandler:theErrorHandler profileErrorCreator:[self profileErrorCreator]];
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
#pragma mark YAProfileCommandErrorHandlerCreator ()

@end
