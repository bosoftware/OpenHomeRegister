//
//  UsersAtInspectTimeTableViewController.h
//  OpenHome
//
//  Created by Bo Wang on 16/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyInspectTime.h"
#import "PropertyObject.h"

@interface UsersAtInspectTimeTableViewController : UITableViewController

@property(nonatomic,retain) NSMutableArray * userArray;

@property(nonatomic,retain) PropertyInspectTime * propertyInspectTime;
@property(nonatomic,retain) PropertyObject * propertyObject;
@end
