//
//  YAAddressHandler.m
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressHandler.h"

#define EMAIL_ADDRESS_ENTITY_NAME @"EmailAddress"
#define MMC_ADDRESS_ENTITY_NAME @"MMCAddress"
#define SMS_ADDRESS_ENTITY_NAME @"SMSAddress"

@implementation YAAddressHandler

- (YAEmailAddress *)createEmailAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:EMAIL_ADDRESS_ENTITY_NAME inManagedObjectContext:theManagedObjectContext];
}

- (YAMMCAddress *)createMMCAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:MMC_ADDRESS_ENTITY_NAME inManagedObjectContext:theManagedObjectContext];
}

- (YASMSAddress *)createSMSAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:SMS_ADDRESS_ENTITY_NAME inManagedObjectContext:theManagedObjectContext];
}

- (void)setHandle:(NSString *)aHandle forAddress:(YAAddress *)anAddress
{
    [anAddress setHandle:aHandle];
}

- (NSString *)handleForAddress:(YAAddress *)theAddress
{
    return [theAddress handle];
}

- (BOOL) isMMCAddressType:(YAAddress *)address;
{
    return [[[address entity] name] isEqualToString:MMC_ADDRESS_ENTITY_NAME];
}

- (BOOL) isSMSAddressType:(YAAddress *)address;
{
    return [[[address entity] name] isEqualToString:SMS_ADDRESS_ENTITY_NAME];
}

- (BOOL) isEmailAddressType:(YAAddress *)address;
{
    return [[[address entity] name] isEqualToString:EMAIL_ADDRESS_ENTITY_NAME];
}

@end
