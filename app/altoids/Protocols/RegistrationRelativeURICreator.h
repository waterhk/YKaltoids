//
//  RegistrationRelativeURICreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationRelativeURICreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)createRelativeURIToRetreiveRegistrationInfo;


@end
