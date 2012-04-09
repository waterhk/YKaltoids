//
//  YAActivityOverlayCommandTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "AppFactory.h"
#import "YAActivityOverlayCommand.h"
#import "ActivityIndicatorOverlay.h"
#import "CommandErrorCreator.h"
#import "YATestThrowingCommand.h"

@interface YAActivityOverlayCommandTests : YATestCase
{
    id activityIndicatorOverlayInstanceFactoryMock;
    id commandErrorCreatorMock;

    id subCommandMock;
    id viewMock;

    YAActivityOverlayCommand* command;

    id activityIndicatorOverlayMock;
}
@end


@implementation YAActivityOverlayCommandTests

- (void) setUp
{
    activityIndicatorOverlayInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(ActivityIndicatorOverlayInstanceFactory)];
    commandErrorCreatorMock = [OCMockObject mockForProtocol:@protocol(CommandErrorCreator)];

    viewMock = [OCMockObject mockForClass:[UIView class]];
    subCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];

    command = [[YAActivityOverlayCommand alloc] initWithCommand:subCommandMock view:viewMock];
    [command setActivityIndicatorOverlayInstanceFactory:activityIndicatorOverlayInstanceFactoryMock];
    [command setCommandErrorCreator:commandErrorCreatorMock];

    activityIndicatorOverlayMock = [OCMockObject mockForProtocol:@protocol(ActivityIndicatorOverlay)];
}


//
// underlying command execution
//

- (void) testExecuteShouldExecuteUnderlyingCommandAndReturnNilUponSuccess
{
    [[activityIndicatorOverlayInstanceFactoryMock stub] createActivityIndicatorOverlay];

    [[subCommandMock expect] execute];

    NSError* result = [command execute];
    STAssertNil(result, nil);
}

- (void) testExecuteShouldReturnErrorFromUnderlyingCommand
{
    [[activityIndicatorOverlayInstanceFactoryMock stub] createActivityIndicatorOverlay];

    NSError* error = [[NSError alloc] init];
    [[[subCommandMock expect] andReturn:error] execute];

    NSError* result = [command execute];
    STAssertEquals(error, result, nil);
}


//
// activity overlay showing/hiding
//

- (void) testExecuteShouldShowActivityOverlayInGivenViewBeforeExecutingUnderlyingCommand
{
    [[activityIndicatorOverlayMock stub] hideActivityIndicatorOverlay];

    __block BOOL shown = NO;
    [[[activityIndicatorOverlayInstanceFactoryMock expect] andReturn:activityIndicatorOverlayMock] createActivityIndicatorOverlay];
    [[[activityIndicatorOverlayMock expect] andDo:^(NSInvocation* x) { shown = YES; }] showActivityIndicatorOverylayWithUpdatingTextInParentView:viewMock];
    [[[subCommandMock expect] andDo:^(NSInvocation* x) { STAssertTrue(shown, nil); }] execute];

    [command execute];
}

- (void) testExecuteShouldHideActivityOverlayAfterExecutingUnderlyingCommand
{
    [[activityIndicatorOverlayMock stub] showActivityIndicatorOverylayWithUpdatingTextInParentView:OCMOCK_ANY];
    
    __block BOOL executed = NO;
    [[[activityIndicatorOverlayInstanceFactoryMock expect] andReturn:activityIndicatorOverlayMock] createActivityIndicatorOverlay];
    [[[activityIndicatorOverlayMock expect] andDo:^(NSInvocation* x) { STAssertTrue(executed, nil); }] hideActivityIndicatorOverlay];
    [[[subCommandMock expect] andDo:^(NSInvocation* x) { executed = YES; }] execute];
    
    [command execute];
}

- (void) testExecuteShouldHideActivityOverlayAfterExecutingUnderlyingCommandThatFails
{
    [[activityIndicatorOverlayMock stub] showActivityIndicatorOverylayWithUpdatingTextInParentView:OCMOCK_ANY];
    
    [[[activityIndicatorOverlayInstanceFactoryMock expect] andReturn:activityIndicatorOverlayMock] createActivityIndicatorOverlay];
    [[activityIndicatorOverlayMock expect] hideActivityIndicatorOverlay];
    [[[subCommandMock expect] andReturn:[[NSError alloc] init]] execute];
    
    [command execute];
}


//
// exception handling
//

- (void) testExecuteShouldCreateAndReturnErrorWhenUnderlyingCommandDoesThrowException
{
    [[activityIndicatorOverlayInstanceFactoryMock stub] createActivityIndicatorOverlay];

    id<Command> throwingCommand = [[YATestThrowingCommand alloc] init];
    [command setCommand:throwingCommand];

    NSError* error = [[NSError alloc] init];
    [[[commandErrorCreatorMock stub] andReturn:error] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];

    NSError* result = [command execute];
    STAssertEquals(result, error, nil);
}

- (void) testExecuteShouldHideOverlayAfterUnderlyingCommandDoesThrowException
{
    [[activityIndicatorOverlayMock stub] showActivityIndicatorOverylayWithUpdatingTextInParentView:OCMOCK_ANY];
    [[commandErrorCreatorMock stub] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];

    YATestThrowingCommand* throwingCommand = [[YATestThrowingCommand alloc] init];
    [command setCommand:throwingCommand];

    [[[activityIndicatorOverlayInstanceFactoryMock expect] andReturn:activityIndicatorOverlayMock] createActivityIndicatorOverlay];
    [[[activityIndicatorOverlayMock expect] andDo:^(NSInvocation* x) { STAssertTrue([throwingCommand threw], nil); }] hideActivityIndicatorOverlay];
    
    [command execute];
}


@end
