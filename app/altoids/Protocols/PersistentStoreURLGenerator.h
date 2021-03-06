//
//  PersistentStoreURLGenerator.h
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersistentStoreURLGenerator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSURL *)persistentStoreURLForStoreType:(NSString *)aStoreType;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
