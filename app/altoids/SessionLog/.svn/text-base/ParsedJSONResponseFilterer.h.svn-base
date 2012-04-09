//
//  ParsedJSONResponseFilterer.h
//  altoids
//
//  Created by Xianzhe Ma on 3/19/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParsedJSONResponseRegexFilterer;

@protocol ParsedJSONResponseFilterer <NSObject>

@property (nonatomic, strong) NSRegularExpression *filterRegex;
@property (nonatomic, strong) id<ParsedJSONResponseRegexFilterer> parsedJSONResponseRegexFilterer;

- (NSString *)filteredStringFromParsedJSONResponse:(NSDictionary *)aParsedJSONResponse;

@end
