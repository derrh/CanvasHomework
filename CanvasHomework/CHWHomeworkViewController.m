//
//  CHWViewController.m
//  CanvasHomework
//
//  Created by Derrick Hathaway on 4/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CHWHomeworkViewController.h"
#import "CHWHomework.h"

@interface CHWHomeworkViewController ()
@end

@implementation CHWHomeworkViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CHWHomework allTehHomeworks] subscribeNext:^(NSArray *homeworks) {
        NSLog(@"hw = %@", homeworks);
    }];
}

@end
