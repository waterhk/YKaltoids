//
//  MMCURLParameterEncoder.h
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMCURLParameterEncoder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)doubleEncodeURLParameterForMMC:(NSString *)theURLParameter;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
