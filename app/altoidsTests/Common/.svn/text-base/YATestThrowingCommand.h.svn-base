//
//  YATestThrowingCommand.h
//  altoids
//
//  Created by Derrick Whittle on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

//
// YATestThrowingCommand exists only to throw exceptions in unit tests.
//
// We can't use OCMock to andThrow an exception anymore:
// http://spin.atomicobject.com/2010/07/06/catching-exceptions-via-nsinvocation-and-nsproxy-is-not-longer-possible-in-objective-c/
//

@interface YATestThrowingCommand : NSObject<Command>

@property (nonatomic, assign) BOOL threw;

@end
