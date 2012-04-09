//
//  URLCreator.h
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import <Foundation/Foundation.h>

@protocol URLCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSURL *)createWithScheme:(NSString *)aScheme server:(NSString *)aServer relativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams;

- (NSURL *)createWithString:(NSString *)theURLString;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
