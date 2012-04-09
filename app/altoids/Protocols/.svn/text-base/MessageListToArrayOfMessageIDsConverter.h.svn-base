//
//  MessageListToArrayOfMessageIDsConverter.h
//  altoids
//
//  Created by Jon Herron on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageListToArrayOfMessageIDsConverter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSArray *)arrayOfMessageIDsFromSetOfMessages:(NSSet *)theMessageSet;
- (NSArray *)arrayOfMessageIDsFromArrayOfMessages:(NSArray *)theMessageArray;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
