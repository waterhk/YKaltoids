//
//  ManagedObjectContextFactory.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManagedObjectContextFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSManagedObjectContext *)create;
- (NSManagedObjectContext *)createWithStalenessInterval:(NSTimeInterval)expiration;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
