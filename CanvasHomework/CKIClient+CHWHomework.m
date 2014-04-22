//
//  CKIClient+CHWHomework.m
//  CanvasHomework
//
//  Created by Derrick Hathaway on 4/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CHWHomework.h"

@implementation CKIClient (CHWHomework)

+ (instancetype)currentClient
{
    static CKIClient *current;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        current = [[CKIClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://mobiledev.instructure.com"]];
        NSString *accessToken = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"access" ofType:@"tkn"] encoding:NSUTF8StringEncoding error:NULL];
        [current setValue:accessToken forKey:@"accessToken"];
    });
    return current;
}

@end
