//
//  JSONParser.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONParser <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)parseJSONData:(NSData *)theData;
- (NSDictionary *)parseJSONString:(NSString *)theString;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
