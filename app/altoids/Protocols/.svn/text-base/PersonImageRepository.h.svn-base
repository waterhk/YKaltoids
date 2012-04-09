//
//  PersonImageRepository.h
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAPersonImage.h"
@protocol PersonImageRepository <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YAPersonImage *)personImageForPhotoURL:(NSString *)photoURL inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)anError;
- (YAPersonImage *)createPersonImageWithPhotoURL:(NSString *)photoURL imageData:(NSData *)imageData
                          inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
