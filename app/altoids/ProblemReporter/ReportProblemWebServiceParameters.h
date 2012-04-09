//
//  ReportProblemWebServiceParameters.h
//  ProblemReporter
//
//  Created by Xianzhe Ma on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportProblemWebServiceParameters <NSObject>

/* Code from Android Hub
 
 String url = String.format("http://submit.msg.yahoo.com/upload?intl=%s&f=%s&bn=%s&r=%s&vid=%s&ctg=%s&sctg=%s",
 "en",
 getLogName(),
 URLEncoder.encode(ApplicationBase.getStringConfig(ApplicationBase.KEY_APP_ID)+"."+ApplicationBase.getInstance().getVersionString()),
 URLEncoder.encode(comment),
 vendorId,
 getCategory(),
 getSubCategory()
 );
 */

- (NSString *)international;
- (NSString *)applicationVersion;
- (NSString *)vendorId;
- (NSString *)category;
- (NSString *)subCagegory;

- (NSString *)logFileName;
- (void)setLogFileName:(NSString *)aLogFileName;

- (NSString *)userComment;
- (void)setUserComment:(NSString *)aUserComment;

@end