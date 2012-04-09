//
//  UserEntityDescriptionCreator.h
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserEntityDescriptionCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSEntityDescription *)userEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
