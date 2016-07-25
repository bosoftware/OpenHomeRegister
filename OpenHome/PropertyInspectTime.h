//
//  PropertyInspectTime.h
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <Parse/Parse.h>
#import "PropertyObject.h"

@interface PropertyInspectTime : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (nonatomic,retain) NSString *inspectTime;
@property(nonatomic,retain) PFUser * currentUser;
@property(nonatomic,retain) PropertyObject * propertyObject;
@end
