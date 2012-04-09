//
//  MMCErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMCErrorCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSError *)errorFromMMCConversationErrors:(NSArray *)theMMCConversationErrors;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
