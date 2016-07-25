//
//  AddEditInspectTimeViewController.h
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyInspectTime.h"

@interface AddEditInspectTimeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;

@property(nonatomic,retain) PropertyInspectTime * inspectTime;
@property(nonatomic,retain) PropertyObject * propertyObject;
@end
