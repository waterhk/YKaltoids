//
//  YAUserProfileResponseParser.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileResponseParser.h"
@protocol JSONParser;

@interface YAUserProfileResponseParser : NSObject<UserProfileResponseParser>

@property (nonatomic, strong) id<JSONParser> jsonParser;

@end
