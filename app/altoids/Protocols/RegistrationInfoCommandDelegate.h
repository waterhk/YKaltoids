//
//  RegistrationInfoCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationInfoCommandDelegate <NSObject>

- (void)registrationInfoDidFailToSaveWithError:(NSError *)error;

- (void)registrationInfoDidSaveWithHandleToObjectIDMap:(NSDictionary *)handleToObjectIDMap;

@end
