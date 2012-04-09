//
//  SMSAddressHandleFormatValidator.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressInfo.h"

@protocol SMSAddressHandleFormatValidator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)validHandleForSMSAddress:(YAAddressInfo *)anSMSAddress;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
