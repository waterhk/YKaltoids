//
//  SettingsErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Errors.h"

@protocol SettingsErrorCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)errorWithCode:(YASettingsErrorCodes)theErrorCode;

- (NSError *)errorWithCode:(YASettingsErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
