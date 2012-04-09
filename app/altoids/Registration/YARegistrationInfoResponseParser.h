//
//  YARegistrationInfoResponseParser.h
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "RegistrationInfoResponseParser.h"
#import "MutableDictionaryCreator.h"

@interface YARegistrationInfoResponseParser : NSObject <RegistrationInfoResponseParser>

@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;

@end
