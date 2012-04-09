//
//  YATimer.h
//  altoids
//
//  Created by Derrick Whittle on 2/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Timer.h"
@protocol DateCreator;


@interface YATimer : NSObject <Timer>

@property (nonatomic, strong) NSMutableDictionary* accumulators; // [NSString* => YATimeAccumulator]
@property (nonatomic, strong) id<DateCreator> dateCreator;

@end


// YATimeAccumulator internal value object used only by YATimer
@interface YATimeAccumulator : NSObject
@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, assign) NSTimeInterval accumulatedSeconds;
@end
