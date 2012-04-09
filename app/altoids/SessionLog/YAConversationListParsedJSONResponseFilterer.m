//
//  YAConversationListParsedJSONResponseFilterer.m
//  altoids
//
//  Created by Xianzhe Ma on 3/19/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationListParsedJSONResponseFilterer.h"
#import "ParsedJSONResponseRegexFilterer.h"

@implementation YAConversationListParsedJSONResponseFilterer

@synthesize filterRegex = filterRegex_;
@synthesize parsedJSONResponseRegexFilterer = parsedJSONResponseRegexFilterer_;

- (id)init {
    if (self = [super init]) {
        filterRegex_ = [NSRegularExpression regularExpressionWithPattern:@"(((snippet)|(subj)|(sTopic))[^=]*=[^\n]*)" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    return self;
}

- (NSString *)filteredStringFromParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    return [[self parsedJSONResponseRegexFilterer] filteredStringFromString:[aParsedJSONResponse description] withRegex:[self filterRegex]];
}

@end
