//
//  Timer.h
//  altoids
//
//  Created by Derrick Whittle on 2/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


// for usage, see docs/design/Timer.md

@protocol Timer <NSObject>

- (void) beginAccumulatingForTag:(NSString*)tag;
- (void) stopAccumulatingForTag:(NSString*)tag;

- (NSTimeInterval) accumulatedSecondsForTag:(NSString*)tag;
- (NSString*) descriptionOfAccumulatedSecondsForAllTags;

@end
