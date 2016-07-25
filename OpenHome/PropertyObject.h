//
//  PropertyObject.h
//  OpenHome
//
//  Created by Bo Wang on 11/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PropertyObject : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (nonatomic,retain) NSString *address;
@property(nonatomic,retain)NSString * suburb;
@property(nonatomic,retain)NSString * state;
@property(nonatomic,retain) NSString *numberOfVisit;
@property(nonatomic,retain) NSString *memo;
@property(nonatomic,retain) PFFile * image;
@property(nonatomic,retain) PFUser * currentUser;
@end
