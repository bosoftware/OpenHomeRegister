//
//  UserObject.h
//  OpenHome
//
//  Created by Bo Wang on 16/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <Parse/Parse.h>
#import "PropertyObject.h"
#import "PropertyInspectTime.h"
#import "QuestionObject.h"


@interface UserObject : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property(nonatomic,retain) PropertyObject * propertyObject;

@property(nonatomic,retain) PropertyInspectTime * propertyInspectTime;

@property(nonatomic,retain) NSMutableDictionary * dictionary;



@end
