//
//  CHWViewController.m
//  CanvasHomework
//
//  Created by Derrick Hathaway on 4/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CHWHomeworkViewController.h"
#import "CHWHomework.h"
#import <MLVCCollectionController.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface CHWHomeworkViewController ()
@property (nonatomic) MLVCCollectionController *collectionController;
@end

@implementation CHWHomeworkViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionController = [MLVCCollectionController collectionControllerGroupingByBlock:^(CHWHomework *hw) {
        return hw.courseID;
    } groupTitleBlock:^(CHWHomework *hw) {
        return hw.courseName;
    } sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES]]];
    
    @weakify(self);
    [self.collectionController.beginUpdatesSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView beginUpdates];
    }];
    [self.collectionController.endUpdatesSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView endUpdates];
    }];
    [self.collectionController.groupsInsertedIndexSetSignal subscribeNext:^(NSIndexSet *sectionIndexes) {
        @strongify(self);
        [self.tableView insertSections:sectionIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self.collectionController.groupsDeletedIndexSetSignal subscribeNext:^(NSIndexSet *sectionIndexes) {
        @strongify(self);
        [self.tableView deleteSections:sectionIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self.collectionController.objectsInsertedIndexPathsSignal subscribeNext:^(NSArray *indexPaths) {
        @strongify(self);
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self.collectionController.objectsDeletedIndexPathsSignal subscribeNext:^(NSArray *indexPaths) {
        @strongify(self);
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    @weakify(self);
    [[CHWHomework allTehHomeworks] subscribeNext:^(NSArray *homeworks) {
        @strongify(self);
        [self.collectionController insertObjects:homeworks];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.collectionController.groups count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MLVCCollectionControllerGroup *group = self.collectionController[section];
    return group.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MLVCCollectionControllerGroup *group = self.collectionController[section];
    return [group.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"HomeworkCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    CHWHomework *hw = [self.collectionController objectAtIndexPath:indexPath];
    cell.textLabel.text = hw.assignmentName;
    cell.detailTextLabel.text = [hw.dueDate description];
    
    return cell;
}

@end
