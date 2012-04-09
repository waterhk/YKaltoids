//
//  JSONParserForMutableResult.h
//  altoids
//
//  Created by Jon Herron on 10/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONParserForMutableResult <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSMutableDictionary *)parseJSONDataForMutableResult:(NSData *)theData;
- (NSMutableDictionary *)parseJSONStringForMutableResult:(NSString *)theString;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
