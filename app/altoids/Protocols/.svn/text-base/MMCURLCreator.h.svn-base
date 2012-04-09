//
//  MMCURLCreator.h
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMCURLCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSURL *)createMMCURLWithRelativeURI:(NSString *)aRelativeURI;
- (NSURL *)createMMCURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
