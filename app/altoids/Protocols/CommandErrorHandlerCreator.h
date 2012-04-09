//
//  CommandErrorHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandErrorHandler.h"
#import "ErrorHandler.h"

@protocol CommandErrorHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<CommandErrorHandler>)createWithErrorHandler:(id<ErrorHandler>)theErrorHandler;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
