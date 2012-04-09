//
//  ErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ErrorHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)handleError:(NSError *)theError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
