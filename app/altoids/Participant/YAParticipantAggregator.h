//
//  YAParticipantAggregator.h
//  altoids
//
//  Created by Jon Herron on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "ParticipantAggregator.h"

@protocol MutableDictionaryCreator;

@interface YAParticipantAggregator : NSObject <ParticipantAggregator>

@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;

@end
