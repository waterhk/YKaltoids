//
//  ConversationViewCellsHeightConfiguration.h
//  altoids
//
//  Created by Xianzhe Ma on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAMessage;

@protocol ConversationViewCellsHeightConfiguration <NSObject>

- (CGFloat)heightOfCellForMessage:(YAMessage *)aMessage;

@end
