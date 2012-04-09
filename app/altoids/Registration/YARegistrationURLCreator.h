//
//  YARegistrationURLCreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationURLCreator.h"
#import "AuthInfoProvider.h"
#import "ServerConfiguration.h"
#import "URLCreator.h"



@interface YARegistrationURLCreator : NSObject<RegistrationURLCreator>

@property (strong, nonatomic) id<AuthInfoProvider> authInfoProvider;
@property (strong, nonatomic) id<ServerConfiguration> serverConfiguration;
@property (strong, nonatomic) id<URLCreator> urlCreator;

@end
