//
//  NSString+DebugFormat.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/14/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "NSString+DebugFormat.h"

@implementation NSString (DebugFormat)

+ (NSString *)formattedDebugDescription:(NSString *)description
{
    NSArray *components = [description componentsSeparatedByString:@"\n"];
    NSString *replaceString = [NSString stringWithFormat:@"\n%88s"," "];
    NSString *formattedStr = [components componentsJoinedByString:replaceString];

    return [NSString stringWithFormat:@"\n%84s=>Info\n%85s\n%88s%s\n%85s\n\n"," ","{"," ",[formattedStr UTF8String],"}"];
}

@end
