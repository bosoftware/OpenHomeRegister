//
//  main.m
//  OpenHome
//
//  Created by Bo Wang on 7/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    int retVal = 0;
    @autoreleasepool {
        NSString *classString = NSStringFromClass([AppDelegate class]);
        @try {
            retVal = UIApplicationMain(argc, argv, nil, classString);
        }
        @catch (NSException *exception) {
            NSLog(@"Exception - %@",[exception description]);
            exit(EXIT_FAILURE);
        }
    }
    return retVal;
}
