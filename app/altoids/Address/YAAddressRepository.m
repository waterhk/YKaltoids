//
//  YAAddressRepository.m
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressRepository.h"
#import "YAAddressInfo.h"
#import "YAEmailAddressInfo.h"
#import "YAMMCAddressInfo.h"
#import "YASMSAddressInfo.h"
#import "YAAddress.h"

// Private class extension
@interface YAAddressRepository ()

// @property definitions

// methods

@end

@implementation YAAddressRepository

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize addressHandler = addressHandler_;
@synthesize addressErrorCreator = addressErrorCreator_;

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

- (YAAddress *)createAddressFromAddressInfo:(YAAddressInfo *)theAddressInfo inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(theManagedObjectContext);
    NSParameterAssert(anError);
    
    NSString *handle;
    YAAddress *address;
    
    if ([theAddressInfo isKindOfClass:[YAEmailAddressInfo class]]) 
    {
        address = [[self addressHandler] createEmailAddressEntityInManagedObjectContext:theManagedObjectContext];
    }
    else if([theAddressInfo isKindOfClass:[YAMMCAddressInfo class]])
    {
        address = [[self addressHandler] createMMCAddressEntityInManagedObjectContext:theManagedObjectContext];
    }
    else if([theAddressInfo isKindOfClass:[YASMSAddressInfo class]])
    {
        address = [[self addressHandler] createSMSAddressEntityInManagedObjectContext:theManagedObjectContext];
    }
    else
    {
        *anError = [[self addressErrorCreator] errorWithCode:YAAddressErrorCodeUnknownAddressType];
        
        return nil;
    }
    
    handle = [theAddressInfo handle];
    
    [[self addressHandler] setHandle:handle forAddress:address];
    
    return address;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAAddressRepository ()

@end
