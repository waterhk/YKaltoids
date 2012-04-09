//
//  ParsedJSONResponseRegexFilterer.h
//  altoids
//
//  Created by Xianzhe Ma on 3/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParsedJSONResponseRegexFilterer <NSObject>

- (NSString *)filteredStringFromString:(NSString *)aString withRegex:(NSRegularExpression *)aRegex;

@end
