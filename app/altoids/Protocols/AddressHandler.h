//
//  AddressHandler.h
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "YAAddress.h"
#import "YAEmailAddress.h"
#import "YAMMCAddress.h"
#import "YASMSAddress.h"

@protocol AddressHandler <NSObject>

- (YAEmailAddress *)createEmailAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;
- (YAMMCAddress *)createMMCAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;
- (YASMSAddress *)createSMSAddressEntityInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (void)setHandle:(NSString *)aHandle forAddress:(YAAddress *)anAddress;

- (NSString *)handleForAddress:(YAAddress *)theAddress;

- (BOOL) isMMCAddressType:(YAAddress *)address;
- (BOOL) isSMSAddressType:(YAAddress *)address;
- (BOOL) isEmailAddressType:(YAAddress *)address;

@end
