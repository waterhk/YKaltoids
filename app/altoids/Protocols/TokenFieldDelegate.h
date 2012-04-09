//
//  TokenFieldDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YATokenField;

@protocol TokenFieldDelegate <NSObject>

@required

- (void)willDeleteToken:(YATokenField*)token;
- (void)didDeleteToken:(YATokenField*)token;

- (void)willSelectToken:(YATokenField*)token;
- (void)didSelectToken:(YATokenField*)token;

@end
