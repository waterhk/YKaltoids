//
//  ErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ErrorCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)errorFromError:(NSError *)theError withUnderlyingError:(NSError *)theUnderlyingError;

- (NSError *)errorWithDomain:(NSString *)theErrorDomain code:(NSInteger)theErrorCode localizedDescription:(NSString *)theLocalizedDescription underlyingError:(NSError *)theUnderlyingError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
