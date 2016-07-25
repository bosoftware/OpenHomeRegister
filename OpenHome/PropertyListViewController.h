//
//  PropertyListViewController.h
//  OpenHome
//
//  Created by Bo Wang on 8/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyListViewController : UIViewController<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (weak, nonatomic) IBOutlet UITableView *propertyTableView;

@property(nonatomic,retain) NSMutableArray * propertyArray;
@property(nonatomic,retain) NSMutableArray * filteredPropertyArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
