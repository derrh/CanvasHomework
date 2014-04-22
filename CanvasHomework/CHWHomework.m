//
//  CHWHomework.m
//  CanvasHomework
//
//  Created by Derrick Hathaway on 4/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CHWHomework.h"
#import "CKIClient+CHWHomework.h"

@implementation CHWHomework
+ (RACSignal *)allTehHomeworks
{
    RACSignal *allCourses = [[CKIClient currentClient] fetchCoursesForCurrentUser];
    RACSignal *allAssignments = [allCourses flattenMap:^RACStream *(NSArray *allCourses) {
        return [allCourses.rac_sequence.signal flattenMap:^RACStream *(CKICourse *course) {
            return [[[CKIClient currentClient] fetchAssignmentsForContext:course] map:^id(NSArray *assignments) {
                return [assignments.rac_sequence map:^id(CKIAssignment *assignment) {
                    CHWHomework *hw = [CHWHomework new];
                    hw.assignmentName = assignment.name;
                    hw.dueDate = assignment.dueAt;
                    hw.courseID = course.id;
                    hw.courseName = course.name;
                    return hw;
                }].array;
            }];
        }];
    }];
    return allAssignments;
}
@end
