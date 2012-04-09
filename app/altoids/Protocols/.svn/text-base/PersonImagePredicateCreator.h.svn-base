//
//  PersonImagePredicateCreator.h
//  altoids
//
//  Created by Anand Subba Rao on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonImagePredicateCreator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSPredicate *)photoURLPredicateMatchingURL:(NSString *)photoURL;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
