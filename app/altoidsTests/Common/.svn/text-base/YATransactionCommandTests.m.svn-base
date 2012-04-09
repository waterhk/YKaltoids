//
//  YATransactionCommandTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YATransactionCommand.h"
#import "TransactionCommandDelegate.h"
#import "CommandErrorCreator.h"
#import "YATestThrowingCommand.h"

@interface YATransactionCommandTests : YATestCase
{
    id commandErrorCreatorMock;

    id subCommandMock;
    id delegateMock;

    YATransactionCommand* command;
}
@end

@interface YATestTransactionCommandDelegate : NSObject<TransactionCommandDelegate>
@property (nonatomic, assign) BOOL shouldThrow;
@end

@interface YATestThrowingCommandErrorCreator : NSObject<CommandErrorCreator>
@end


@implementation YATransactionCommandTests

- (void) setUp
{
    commandErrorCreatorMock = [OCMockObject mockForProtocol:@protocol(CommandErrorCreator)];

    subCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    delegateMock = [OCMockObject mockForProtocol:@protocol(TransactionCommandDelegate)];

    command = [[YATransactionCommand alloc] initWithCommand:subCommandMock delegate:delegateMock];
    [command setCommandErrorCreator:commandErrorCreatorMock];
}


//
// underlying command execution
//

- (void) testExecuteShouldExecuteUnderlyingCommandAndReturnNilUponSuccess
{
    [[delegateMock stub] commandTransactionDidSucceed:OCMOCK_ANY];

    [[subCommandMock expect] execute];

    NSError* result = [command execute];
    STAssertNil(result, nil);
}

- (void) testExecuteShouldReturnErrorFromUnderlyingCommand
{
    [[delegateMock stub] commandTransaction:OCMOCK_ANY didFailWithError:OCMOCK_ANY];

    NSError* error = [[NSError alloc] init];
    [[[subCommandMock expect] andReturn:error] execute];

    NSError* result = [command execute];
    STAssertEquals(error, result, nil);
}


//
// transaction token
//

- (void) testTransactionShouldReturnCommandItselfAsTransactionToken
{
    id<CommandTransaction> token = [command transaction];
    STAssertEquals(command, token, nil);
}


//
// delegate notification
//

- (void) testExecuteShouldNotifyDelegateOfSuccessAfterSuccessfulUnderlyingCommandCompletion
{
    __block BOOL executed = NO;
    [[[subCommandMock expect] andDo:^(NSInvocation* x) { executed = YES; }] execute];
    [[[delegateMock expect] andDo:^(NSInvocation* x) { STAssertTrue(executed, nil); }] commandTransactionDidSucceed:command];

    [command execute];
}

- (void) testExecuteShouldNotifyDelegateWithErrorAfterFailedUnderlyingCommandCompletion
{
    __block BOOL executed = NO;
    NSError* error = [[NSError alloc] init];
    [[[[subCommandMock expect] andDo:^(NSInvocation* x) { executed = YES; }] andReturn:error] execute];
    [[[delegateMock expect] andDo:^(NSInvocation* x) { STAssertTrue(executed, nil); }] commandTransaction:command didFailWithError:error];
    
    [command execute];
}


//
// exception handling
//

- (void) testExecuteShouldCreateAndReturnErrorWhenUnderlyingCommandDoesThrowException
{
    [[delegateMock stub] commandTransaction:OCMOCK_ANY didFailWithError:OCMOCK_ANY];

    id<Command> throwingCommand = [[YATestThrowingCommand alloc] init];
    [command setCommand:throwingCommand];

    NSError* error = [[NSError alloc] init];
    [[[commandErrorCreatorMock expect] andReturn:error] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];

    NSError* result = [command execute];
    STAssertEquals(error, result, nil);
}

- (void) testExecuteShouldCreateErrorAndNotifyDelegateWhenUnderlyingCommandDoesThrowException
{
    id<Command> throwingCommand = [[YATestThrowingCommand alloc] init];
    [command setCommand:throwingCommand];
    
    NSError* error = [[NSError alloc] init];
    [[[commandErrorCreatorMock expect] andReturn:error] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];
    [[delegateMock expect] commandTransaction:command didFailWithError:error];
    
    [command execute];
}


//
// delegate lifecycle management (breaking reference cycle between YATransactionCommand and its delegate)
//

- (void) testExecuteShouldReleaseDelegateWhenUnderlyingCommandDoesSucceed
{
    [[subCommandMock expect] execute];

    id<TransactionCommandDelegate> delegate = [[YATestTransactionCommandDelegate alloc] init];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];

    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);

    [command execute];

    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}

- (void) testExecuteShouldReleaseDelegateWhenUnderlyingCommandDoesFail
{
    [[[subCommandMock expect] andReturn:[[NSError alloc] init]] execute];
    
    id<TransactionCommandDelegate> delegate = [[YATestTransactionCommandDelegate alloc] init];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];
    
    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);
    
    [command execute];
    
    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}

- (void) testExecuteShouldReleaseDelegateWhenUnderlyingCommandDoesThrowException
{
    [[commandErrorCreatorMock stub] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];

    id<Command> throwingCommand = [[YATestThrowingCommand alloc] init];
    [command setCommand:throwingCommand];
    
    id<TransactionCommandDelegate> delegate = [[YATestTransactionCommandDelegate alloc] init];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];
    
    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);
    
    [command execute];
    
    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}

- (void) testExecuteShouldReleaseDelegateWhenCommandErrorCreatorDoesThrowException
{
    [[subCommandMock expect] execute];

    YATestThrowingCommandErrorCreator* commandErrorCreator = [[YATestThrowingCommandErrorCreator alloc] init];
    [command setCommandErrorCreator:commandErrorCreator];

    YATestTransactionCommandDelegate* delegate = [[YATestTransactionCommandDelegate alloc] init];
    [delegate setShouldThrow:YES];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];
    
    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);

    @try
    {
        [command execute];
    }
    @catch(id exception) { }
    
    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}

- (void) testExecuteShouldReleaseDelegateWhenDelegateDoesThrowExceptionUponSuccessNotification
{
    [[subCommandMock expect] execute];

    YATestTransactionCommandDelegate* delegate = [[YATestTransactionCommandDelegate alloc] init];
    [delegate setShouldThrow:YES];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];
    
    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);

    @try
    {
        [command execute];
    }
    @catch(id exception) { }
    
    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}

- (void) testExecuteShouldReleaseDelegateWhenDelegateDoesThrowExceptionUponFailureNotification
{
    [[[subCommandMock expect] andReturn:[[NSError alloc] init]] execute];

    YATestTransactionCommandDelegate* delegate = [[YATestTransactionCommandDelegate alloc] init];
    [delegate setShouldThrow:YES];
    NSUInteger initialRetainCount = [self retainCountForObject:delegate];
    
    [command setDelegate:delegate];
    STAssertTrue([self retainCountForObject:delegate] != initialRetainCount, nil);
    
    @try
    {
        [command execute];
    }
    @catch(id exception) { }
    
    STAssertNil([command delegate], nil);
    NSUInteger finalRetainCount = [self retainCountForObject:delegate];
    STAssertEquals(initialRetainCount, finalRetainCount, nil);
}


@end



@implementation YATestTransactionCommandDelegate
@synthesize shouldThrow;
- (void) commandTransactionDidSucceed:(id<CommandTransaction>)commandTransaction
{
    if(shouldThrow)
    {
        [NSException raise:@"some exception" format:@"with some description"];
    }
}
- (void) commandTransaction:(id<CommandTransaction>)commandTransaction didFailWithError:(NSError *)error
{
    if(shouldThrow)
    {
        [NSException raise:@"some exception" format:@"with some description"];
    }
}
@end

@implementation YATestThrowingCommandErrorCreator
- (NSError*) errorWithCode:(YACommandErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    [NSException raise:@"some exception" format:@"with some description"];
    return nil;
}
- (NSError*) errorWithCode:(YACommandErrorCodes)theErrorCode
{
    [NSException raise:@"some exception" format:@"with some description"];
    return nil;
}
@end
