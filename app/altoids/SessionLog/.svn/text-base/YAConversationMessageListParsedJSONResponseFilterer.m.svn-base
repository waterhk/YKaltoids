//
//  YAConversationMessageListParsedJSONResponseFilterer.m
//  altoids
//
//  Created by Xianzhe Ma on 3/20/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListParsedJSONResponseFilterer.h"
#import "ParsedJSONResponseRegexFilterer.h"

@implementation YAConversationMessageListParsedJSONResponseFilterer

@synthesize filterRegex = filterRegex_;
@synthesize parsedJSONResponseRegexFilterer = parsedJSONResponseRegexFilterer_;

- (id)init
{
    if (self = [super init]) {
        filterRegex_ = [NSRegularExpression regularExpressionWithPattern:@"(((content)|(subj)|(sTopic))[^=]*=[^\n]*)" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    return self;
}

- (NSString *)filteredStringFromParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    return [[self parsedJSONResponseRegexFilterer] filteredStringFromString:[aParsedJSONResponse description] withRegex:[self filterRegex]];
}

@end
