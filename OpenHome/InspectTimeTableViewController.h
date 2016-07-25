//
//  InspectTimeTableViewController.h
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyObject.h"

@interface InspectTimeTableViewController : UITableViewController
@property (nonatomic,retain) PropertyObject * propertyObject;
@property(nonatomic,retain)NSMutableArray * inspectTimeArray;

@end
