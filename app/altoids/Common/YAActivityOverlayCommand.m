//
//  YAActivityOverlayCommand.m
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAActivityOverlayCommand.h"
#import "AppFactory.h"
#import "ActivityIndicatorOverlay.h"
#import "CommandErrorCreator.h"

@implementation YAActivityOverlayCommand

@synthesize activityIndicatorOverlayInstanceFactory = activityIndicatorOverlayInstanceFactory_,
            commandErrorCreator = commandErrorCreator_,
            command = command_,
            view = view_;


- (id) initWithCommand:(id<Command>)command view:(UIView*)view
{
    NSAssert(command, @"Need an underlying command to execute.");
    NSAssert(view, @"It doesn't make sense to create a YAActivityOverlayCommand without a view in which to render the overlay.");
    
    self = [super init];
    if(self)
    {
        command_ = command;
        view_ = view;
    }
    return self;
}

- (NSError*) execute
{
    id<ActivityIndicatorOverlay> overlay = [activityIndicatorOverlayInstanceFactory_ createActivityIndicatorOverlay];
    [overlay showActivityIndicatorOverylayWithUpdatingTextInParentView:view_];

    NSError* error;
    @try
    {
        error = [command_ execute];
    }
    @catch(id exception)
    {
        error = [commandErrorCreator_ errorWithCode:YACommandErrorCodeException underlyingError:error];
    }
    @finally
    {
        [overlay hideActivityIndicatorOverlay];
    }
    
    return error;
}

@end
