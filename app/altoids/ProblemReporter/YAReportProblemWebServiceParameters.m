//
//  YAReportProblemWebServiceParameters.m
//  altoids
//
//  Created by Xianzhe Ma on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAReportProblemWebServiceParameters.h"
#import "URLParameterEncoder.h"

@implementation YAReportProblemWebServiceParameters

@synthesize logFileName = logFileName_;
@synthesize userComment = userComment_;

@synthesize urlParameterEncoder = urlParameterEncoder_;

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)international {
    return @"us";
}

- (NSString *)applicationVersion {
    NSString *svnBuildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	NSString *versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [[self urlParameterEncoder] encodeURLParameter:[versionNumber stringByAppendingFormat:@" (%@)", svnBuildNumber]];
}

- (NSString *)vendorId {
    return @"512";
}

- (NSString *)category {
    return @"1";
}

- (NSString *)subCagegory {
    return @"1";
}

- (void)setUserComment:(NSString *)aUserComment {
    userComment_ = [[self urlParameterEncoder] encodeURLParameter:aUserComment];
}

@end
