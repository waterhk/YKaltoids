//
//  Threader.h
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


//
// Threader provides convenient, testable routines for performing selectors on a particular thread.
// Most often, Threader will be used to thunk up to the main (UI) thread, using the "mainThreader" aff component.
//

@protocol Threader <NSObject>

// performs the given selector on the given target, executing on the Threader's configured thread without blocking until execution is complete
- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject*)target;

// performs the given selector on the given target, with the given argument, executing on the Threader's configured thread without blocking until execution is complete
- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument;

// performs the given selector on the given target, with the given arguments, executing on the Threader's configured thread without blocking until execution is complete
- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument andObject:(id)anotherArgument;

// performs the given selector on the given target, executing on the Threader's configured thread and blocking until execution is complete
- (void) performSelector:(SEL)selector onTarget:(NSObject*)target;

// performs the given selector on the given target, with the given argument, executing on the Threader's configured thread and blocking until execution is complete
- (void) performSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument;

// performs the given selector on the given target, with the given arguments, executing on the Threader's configured thread and blocking until execution is complete
- (void) performSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument andObject:(id)anotherArgument;

@end
