//
//  RegistrationURLCreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationURLCreator <NSObject>

@required

- (NSURL *)createRegistrationURLWithRelativeURI:(NSString *)aRelativeURI;
- (NSURL *)createRegistrationURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams;


@end
