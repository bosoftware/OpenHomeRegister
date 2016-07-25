//
//  Utility.h
//  OpenHome
//
//  Created by Bo Wang on 25/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;
@end
