//
//  DataCreator.h
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSData *)createWithContentsOfURL:(NSURL *)theURL;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
