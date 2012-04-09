//
//  ConversationEditURLParametersCreator.h
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConversationEditURLParametersCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)urlParametersForConversationEdit;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
