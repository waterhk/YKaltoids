//
//  JSONWriter.h
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONWriter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSData *)dataFromDictionary:(NSDictionary *)theDictionary;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
