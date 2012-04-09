//
//  YAParsedJSONResponseRegexFilterer.m
//  altoids
//
//  Created by Xianzhe Ma on 3/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAParsedJSONResponseRegexFilterer.h"

@implementation YAParsedJSONResponseRegexFilterer

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(NSString *)filteredStringFromString:(NSString *)aString withRegex:(NSRegularExpression *)aRegex
{
    if (!aString) {
        return nil;
    }
    
    NSMutableString *responseMutableString = [aString mutableCopy];
    
    [aRegex replaceMatchesInString:responseMutableString options:0 range:NSMakeRange(0, [responseMutableString length]) withTemplate:kFilteredStringReplacement];
    
    return responseMutableString;
}

@end
