//
//  UserObject.m
//  OpenHome
//
//  Created by Bo Wang on 16/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject

@dynamic propertyInspectTime,propertyObject,dictionary;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Visitors";
}


@end
