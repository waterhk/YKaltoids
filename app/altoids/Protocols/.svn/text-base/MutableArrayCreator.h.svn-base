//
//  MutableArrayCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MutableArrayCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSMutableArray *)mutableArrayWithCapacity:(NSUInteger)theCapacity;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
