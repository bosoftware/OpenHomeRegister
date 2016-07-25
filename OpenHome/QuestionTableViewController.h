//
//  QuestionTableViewController.h
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewController : UITableViewController

@property(nonatomic,retain) NSMutableArray * questionArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButtonItem;

@end
