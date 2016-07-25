//
//  QuestionValueObject.h
//  OpenHome
//
//  Created by Bo Wang on 24/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "QuestionObject.h"


@interface QuestionValueObject : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property(nonatomic,retain) QuestionObject * question;
@property(nonatomic,retain) NSString *answer;

@end
