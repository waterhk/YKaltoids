//
//  YAMessageGapDetector.h
//  altoids
//
//  Created by Anand Subba Rao on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageGapDetector.h"
#import "MessageHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMessageGapDetector : NSObject <MessageGapDetector>

#pragma mark @property declarations
@property (nonatomic, strong) id<MessageHandler> messageHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
