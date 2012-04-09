//
//  YACommandErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandErrorHandler.h"
#import "ErrorHandler.h"
#import "CommandErrorCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YACommandErrorHandler : NSObject <CommandErrorHandler>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithErrorHandler:(id<ErrorHandler>)theErrorHandler 
       commandErrorCreator:(id<CommandErrorCreator>)theCommandErrorCreator;

@end
