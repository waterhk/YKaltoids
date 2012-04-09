//
//  MutableDictionaryCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MutableDictionaryCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSMutableDictionary *)mutableDictionaryWithCapacity:(NSUInteger)theCapacity;
- (NSMutableDictionary *)mutableDictionaryWithDictionary:(NSDictionary *)theDictionary;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
