//
//  AuthenticationErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSMErrors.h"

@protocol AuthenticationErrorCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)errorWithCode:(YSMAuthenticationErrorCodes)theErrorCode;

- (NSError *)errorWithCode:(YSMAuthenticationErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError;

- (NSError *)errorWithDomain:(NSString *)theErrorDomain code:(NSInteger)theErrorCode localizedDescription:(NSString *)theLocalizedDescription underlyingError:(NSError *)theUnderlyingError;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
