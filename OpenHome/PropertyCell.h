//
//  AppCell.h
//  Top Apps
//
//  Created by Vinodh  on 27/12/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PropertyObject;
@interface PropertyCell : UITableViewCell
- (void)configureCellForAppRecord:(PropertyObject *)property;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
