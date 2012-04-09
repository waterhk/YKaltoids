//
//  FilesystemPathGenerator.m
//  SessionManager3
//
//  Created by Lei Cai on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMFilesystemPathGenerator.h"

@implementation YSMFilesystemPathGenerator

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// We may decided to add more complicated checks here
- (NSString*)getPath:(NSString*)aFilename
{
    if (!aFilename) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:aFilename];
}

@end
