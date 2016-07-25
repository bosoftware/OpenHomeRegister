//
//  PropertyInspectTime.m
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "PropertyInspectTime.h"

@implementation PropertyInspectTime

@dynamic currentUser,inspectTime,propertyObject;
+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"PropertyInspectTime";
}
@end
