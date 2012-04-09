//
//  CommandFactory.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@protocol CommandFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<Command>)conversationListCommand;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
