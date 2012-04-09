//
//  PersonImageHandler.h
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAPersonImage.h"

@protocol PersonImageHandler <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YAPersonImage *)createPersonImageEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (void)setPhotoURL:(NSString *)photoURL forPersonImage:(YAPersonImage *)personImage;
- (void)setImageData:(NSData *)imageData forPersonImage:(YAPersonImage *)personImage;

- (NSData *)imageDataForPersonImage:(YAPersonImage *)personImage;
- (NSString *)photoURLForPersonImage:(YAPersonImage *)personImage;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
