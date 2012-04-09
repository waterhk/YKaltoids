//
//  ArrayFilterer.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArrayFilterer <NSObject>

- (NSArray *)filterArray:(NSArray *)theArray usingPredicate:(NSPredicate *)thePredicate;

- (NSArray*) arrayFromArray:(NSArray*)array excludingObjectsInSet:(NSSet*)set;

@end
