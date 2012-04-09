//
//  YAMessageEntityDescriptionCreator.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageEntityDescriptionCreator.h"

@implementation YAMessageEntityDescriptionCreator

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

- (NSEntityDescription *)messageEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    return [NSEntityDescription entityForName:kMessageEntityName inManagedObjectContext:theManagedObjectContext];
}

@end
