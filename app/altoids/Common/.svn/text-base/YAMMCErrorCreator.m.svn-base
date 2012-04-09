//
//  YAMMCErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCErrorCreator.h"

// Private class extension
@interface YAMMCErrorCreator ()

// @property definitions

// methods

@end

@implementation YAMMCErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorCreator = errorCreator_;

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
#pragma mark MMCErrorCreator delegate methods

- (NSError *)errorFromMMCConversationErrors:(NSArray *)theMMCConversationErrors
{
    NSUInteger errorsCount = [theMMCConversationErrors count];
    
    if (errorsCount == 0) 
    {
        return nil;
    }
    
    if (errorsCount == 1) 
    {
        return [theMMCConversationErrors objectAtIndex:0];
    }
    
    NSError *error;
    
    for (int i = errorsCount - 1; i > -1; --i) 
    {
        error = [[self errorCreator] errorFromError:[theMMCConversationErrors objectAtIndex:i] withUnderlyingError:error];
    }
    
    return error;
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
#pragma mark YAMMCErrorCreator ()

@end
