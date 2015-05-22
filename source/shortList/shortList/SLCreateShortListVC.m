//
//  SLCreateShortListVC.m
//  shortList
//
//  Created by Dustin Bergman on 5/17/15.
//  Copyright (c) 2015 Dustin Bergman. All rights reserved.
//

#import "SLCreateShortListVC.h"
#import "SLStyle.h"
#import "SLCreateShortListTitleCell.h"
#import "SLCreateShortListButtonCell.h"
#import "SLCreateShortListEnterNameCell.h"
#import "SLCreateShortListEnterYearCell.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const kSLCreateShortListPickerHeight = 180.0;
CGFloat const kSLCreateShortListCellHeight = 44.0;
NSInteger const kSLCreateShortListCellCount = 4;

@interface SLCreateShortListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL showingYearPicker;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLCreateShortListEnterYearCell *yearPickerCell;
@property (nonatomic, strong) NSString *shortListName;
@property (nonatomic, strong) NSString *shortListYear;

@end

@implementation SLCreateShortListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor sl_Red];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.layer.cornerRadius = 10;
    self.tableView.alpha = .8;
    self.tableView.scrollEnabled = NO;
    [self.tableView setAutoresizesSubviews:YES];
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];

    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kSLCreateShortListCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TitleCellIdentifier = @"TitleCell";
    static NSString *ButtonCellIdentifier = @"ButtonCell";
    static NSString *NameCellIdentifier = @"NameCell";
    static NSString *YearCellIdentifier = @"YearCell";
    
    __weak typeof(self) weakself = self;
    if (indexPath.row == 0) {
        SLCreateShortListTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCellIdentifier];
        if (cell == nil) {
            cell = [[SLCreateShortListTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TitleCellIdentifier];
        }
        
        return cell;
    }
    else if (indexPath.row == 1) {
        SLCreateShortListEnterNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NameCellIdentifier];
        if (cell == nil) {
            cell = [[SLCreateShortListEnterNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NameCellIdentifier];
        }
        [cell setCreateNameAction:^(NSString *shortListName){
            weakself.shortListName = shortListName;
        }];
        
        return cell;
    }
    else if (indexPath.row == 2) {
        SLCreateShortListEnterYearCell *cell = [tableView dequeueReusableCellWithIdentifier:YearCellIdentifier];
        if (cell == nil) {
            cell = [[SLCreateShortListEnterYearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YearCellIdentifier];
        }
        self.yearPickerCell = cell;
        
        [cell setCreateYearAction:^(NSString *shortListYear){
            weakself.shortListYear = shortListYear;
        }];
        
        return cell;
    }
    
    SLCreateShortListButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:ButtonCellIdentifier];
    if (cell == nil) {
        cell = [[SLCreateShortListButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ButtonCellIdentifier];
    }
    __weak typeof(self) weakSelf = self;
    [cell setCancelBlock:^ {
        weakSelf.showingYearPicker = NO;
        [weakSelf.yearPickerCell hidePickerCell];
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
        if (weakSelf.cancelButtonAction) {
            weakSelf.cancelButtonAction();
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 && !self.showingYearPicker) {
        self.showingYearPicker = YES;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
        
        if ([self.delegate respondsToSelector:@selector(createShortList:willDisplayPickerWithHeight:)]) {
            [self.delegate createShortList:self willDisplayPickerWithHeight:kSLCreateShortListPickerHeight];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        if (self.showingYearPicker) {
             return kSLCreateShortListPickerHeight;
        }
    }
    
    return kSLCreateShortListCellHeight;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setLayoutMargins:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

@end
