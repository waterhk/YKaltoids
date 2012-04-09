//
//  UserProfileImageScaler.h
//  altoids
//
//  Created by Jon Herron on 1/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserProfileImageScaler <NSObject>

- (UIImage *)scaleUserProfileImage:(UIImage *)theUserProfileImage;

@end
