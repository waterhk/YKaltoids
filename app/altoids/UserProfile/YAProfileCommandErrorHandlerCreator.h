//
//  YAProfileCommandErrorHandlerCreator.h
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandErrorHandlerCreator.h"
#import "ProfileErrorCreator.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAProfileCommandErrorHandlerCreator : NSObject<CommandErrorHandlerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ProfileErrorCreator> profileErrorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
