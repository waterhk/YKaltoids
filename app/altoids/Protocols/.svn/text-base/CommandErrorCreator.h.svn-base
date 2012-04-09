//
//  CommandErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommandErrorCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)errorWithCode:(YACommandErrorCodes)theErrorCode;

- (NSError *)errorWithCode:(YACommandErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
