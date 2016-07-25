//
//  QuestionValueObject.m
//  OpenHome
//
//  Created by Bo Wang on 24/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "QuestionValueObject.h"

@implementation QuestionValueObject
+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"QuestionValueObject";
}


@end
