//
//  YAFetchRequestRepository.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "FetchRequestRepository.h"
#import "EntityDescriptionCreator.h"
#import "FetchRequestCreator.h"
#import "PredicateCreator.h"

@interface YAFetchRequestRepository : NSObject <FetchRequestRepository>

@property (strong, nonatomic) id<EntityDescriptionCreator> entityDescriptionCreator;
@property (strong, nonatomic) id<FetchRequestCreator> fetchRequestCreator;
@property (strong, nonatomic) id<PredicateCreator> predicateCreator;

@end
