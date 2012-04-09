//
//  YAPersonImage.h
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YAPerson;

@interface YAPersonImage : NSManagedObject

@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSSet *persons;
@end

@interface YAPersonImage (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(YAPerson *)value;
- (void)removePersonsObject:(YAPerson *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;
@end
