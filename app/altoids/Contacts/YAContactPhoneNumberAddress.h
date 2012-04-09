//
//  YAContactPhoneNumberAddress.h
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAContactAddress.h"

@interface YAContactPhoneNumberAddress : YAContactAddress

@property (nonatomic, strong, readonly) NSString* displayPhoneNumber;

- (id) initWithDisplayPhoneNumber:(NSString*)displayPhoneNumber label:(NSString*)label;

@end
