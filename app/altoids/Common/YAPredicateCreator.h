//
//  YAPredicateCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "PredicateCreator.h"

@protocol MutableArrayCreator;

@interface YAPredicateCreator : NSObject <PredicateCreator>

@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;

@end
