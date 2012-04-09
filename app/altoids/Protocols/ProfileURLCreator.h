//
//  ProfileURLCreator.h
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfileURLCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSURL *)createProfileURLWithRelativeURI:(NSString *)aRelativeURI;
- (NSURL *)createProfileURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
