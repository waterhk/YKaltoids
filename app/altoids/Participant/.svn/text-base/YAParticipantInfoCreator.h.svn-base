//
//  YAParticipantInfoCreator.h
//  altoids
//
//  Created by Derrick Whittle on 4/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticipantInfoCreator.h"
@protocol AddressInfoCreator, UserProfileRepository, RegistrationFetcher;


@interface YAParticipantInfoCreator : NSObject <ParticipantInfoCreator>

@property (nonatomic, strong) id<AddressInfoCreator> addressInfoCreator;
@property (nonatomic, strong) id<UserProfileRepository> userProfileRepository;
@property (nonatomic, strong) id<RegistrationFetcher> registrationFetcher;

@end
