//
//  RegistrationFetcher.h
//  altoids
//
//  Created by Anand Subba Rao on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YARegistrationInfo;
@class NSManagedObjectContext;

@protocol RegistrationFetcher <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YARegistrationInfo *)fetchRegistrationInfoInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
