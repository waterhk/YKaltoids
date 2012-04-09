//
//  MessageGapDetector.h
//  altoids
//
//  Created by Anand Subba Rao on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMessage.h"

@protocol MessageGapDetector <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAMessage *)messageImmediatelyBeforePossibleGapWithExistingMessages:(NSSet *)existingMessages
                                                           newMessages:(NSSet *)newMessages
                                                messageInfosWithIdOnly:(NSArray *)messageInfosWithIdOnly;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
