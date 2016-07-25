//
//  AppCell.m
//  Top Apps
//
//  Created by Vinodh  on 27/12/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.
//

#import "PropertyCell.h"
#import "PropertyObject.h"
#import "UIImageView+Networking.h"

@interface PropertyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *memo;
@property (weak, nonatomic) IBOutlet UILabel *visitNumber;


@property (nonatomic) PropertyObject *property;
@end

@implementation PropertyCell

- (void)configureCellForAppRecord:(PropertyObject *)property
{
    self.property = property;
    
    [self.iconView setImage:[UIImage imageNamed:@"logo"]];
    
    self.address.text = [NSString stringWithFormat:@"%@ %@ %@",property.address,property.suburb,property.state];
    self.memo.text = property.memo;
    self.visitNumber.text = property.numberOfVisit;
    
    
    PFFile *userImageFile = property.image;
    if (userImageFile!=nil){
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            [self.iconView setImage:image];
        }
    }];
    }
}

@end
