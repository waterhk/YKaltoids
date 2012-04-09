//
//  ArraySplitter.h
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArraySplitter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSArray *)splitArray:(NSArray *)theArray intoGroupsOfSize:(NSUInteger)theGroupSize;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
