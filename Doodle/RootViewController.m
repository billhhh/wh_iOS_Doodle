//
//  RootViewController.m
//  Doodle
//
//  Created by yy c on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DoodleView.h"
@implementation RootViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
    DoodleView *doodleView = [[DoodleView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    doodleView.backgroundColor = [UIColor grayColor];
    self.view = doodleView;
    [doodleView release];
}

@end
