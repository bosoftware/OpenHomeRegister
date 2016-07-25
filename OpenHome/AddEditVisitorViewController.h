//
//  AddEditVisitorViewController.h
//  OpenHome
//
//  Created by Bo Wang on 23/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyObject.h"
#import "PropertyInspectTime.h"
#import "UserObject.h"

@interface AddEditVisitorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *QuestionListTableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myIndicator;

@property(nonatomic,retain) PropertyObject * propertyObject;

@property(nonatomic,retain) PropertyInspectTime * inspectTime;

@property(nonatomic,retain) UserObject * userObject;


@end
