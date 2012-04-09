//
//  Logging.h
//  altoids
//
//  Created by Jon Herron on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "lcl.h" // LibComponentLogging module
#import "YALog.h" // Short macros for logging in Altoids

#define kYALogComponent lcl_cDefault

#ifndef ALTOIDS_LOGGING_H
#define ALTOIDS_LOGGING_H

#define ALOG(fmt, ...) do { NSLog([NSString stringWithFormat:@"%@ %@", @"%s:%d", fmt], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); } while(0)

#endif
