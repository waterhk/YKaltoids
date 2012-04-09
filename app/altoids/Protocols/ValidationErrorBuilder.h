//
//  ValidationErrorBuilder.h
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ValidationErrorBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)validationErrorWithCode:(NSUInteger)aCode message:(NSString *)aMessage;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
