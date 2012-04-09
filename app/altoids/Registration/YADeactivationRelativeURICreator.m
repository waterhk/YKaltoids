//
//  YADeactivationRelativeURICreator.m
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADeactivationRelativeURICreator.h"
#define kRegistrationInfoRelativeURI @"mmc/reg/v1/registrationInfo/my"


@implementation YADeactivationRelativeURICreator

- (NSString *)createRelativeURIToRetreiveRegistrationInfo 
{
    return kRegistrationInfoRelativeURI;

}

@end
