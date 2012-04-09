//
//  YAActivityOverlayCommand.h
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
@protocol ActivityIndicatorOverlayInstanceFactory, CommandErrorCreator;

// YAActivityOverlayCommand presents an activity overlay while it executes an underlying command.
@interface YAActivityOverlayCommand : NSObject <Command>

// injected dependencies
@property (strong, nonatomic) id<ActivityIndicatorOverlayInstanceFactory> activityIndicatorOverlayInstanceFactory;
@property (strong, nonatomic) id<CommandErrorCreator> commandErrorCreator;

// operational parameters
@property (strong, nonatomic) id<Command> command;
@property (strong, nonatomic) UIView* view;

- (id) initWithCommand:(id<Command>)command view:(UIView*)view;

@end
