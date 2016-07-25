//
//  AddEditPropertyViewController.h
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyObject.h"
@interface AddEditPropertyViewController : UIViewController
@property(nonatomic,retain) PropertyObject * property;
@property (weak, nonatomic) IBOutlet UIImageView *propertyImageView;

@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UITextField *suburb;
@property (weak, nonatomic) IBOutlet UITextField *state;

@property (nonatomic,retain) UIImage * image;

@end
