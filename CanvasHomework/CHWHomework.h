//
//  CHWHomework.h
//  CanvasHomework
//
//  Created by Derrick Hathaway on 4/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CHWHomework : NSObject

+ (RACSignal *)allTehHomeworks;

@property (nonatomic) NSString *assignmentName;
@property (nonatomic) NSString *courseName;
@property (nonatomic) NSString *courseID;
@property (nonatomic) NSDate *dueDate;
@end
