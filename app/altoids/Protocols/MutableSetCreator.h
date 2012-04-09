//
//  MutableSetCreator.h
//  altoids
//
//  Created by Anand Subba Rao on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MutableSetCreator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSMutableSet *)mutableSetWithCapacity:(NSUInteger)capacity;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
