//
//  PropertyObject.m
//  OpenHome
//
//  Created by Bo Wang on 11/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "PropertyObject.h"
#import <Parse/PFObject+Subclass.h>
@implementation PropertyObject

@dynamic address,suburb,state,memo,numberOfVisit,image,currentUser;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"PropertyObject";
}


@end
