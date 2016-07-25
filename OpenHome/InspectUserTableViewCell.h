//
//  InspectUserTableViewCell.h
//  OpenHome
//
//  Created by Bo Wang on 18/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *email;

@end
