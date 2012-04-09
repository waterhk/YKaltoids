//
//  AddressRepository.h
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "YASMSAddress.h"
#import "YAParticipant.h"
#import "YAAddressInfo.h"

@protocol AddressRepository <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAAddress *)createAddressFromAddressInfo:(YAAddressInfo *)theAddressInfo inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
