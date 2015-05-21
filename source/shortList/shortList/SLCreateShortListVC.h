//
//  SLCreateShortListVC.h
//  shortList
//
//  Created by Dustin Bergman on 5/17/15.
//  Copyright (c) 2015 Dustin Bergman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kSLCreateShortListPickerHeight;
extern CGFloat const kSLCreateShortListCellHeight;
extern NSInteger const kSLCreateShortListCellCount;

@class SLCreateShortListVC;

@protocol SLCreateShortListDelegate <NSObject>

- (void)createShortList:(SLCreateShortListVC *)viewController willDisplayPickerWithHeight:(CGFloat)pickerHeight;

@end

@interface SLCreateShortListVC : UIViewController

@property (nonatomic, weak) id <SLCreateShortListDelegate> delegate;
@property (nonatomic, copy) dispatch_block_t cancelButtonAction;

@end
