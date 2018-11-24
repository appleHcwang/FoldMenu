//
//  IFLYFoldMenuView.h
//  IFLYFoldMenuView
//
//  Created by admin on 2018/11/24.
//  Copyright © 2018年 admin. All rights reserved.
//


#import <UIKit/UIKit.h>
@class IFLYFoldMenuView;
@protocol IFLYFoldMenuViewDelegate <NSObject>
- (void)foldMenuView:(IFLYFoldMenuView *)button clickButtonAtIndex:(int)index;
@end
@interface IFLYFoldMenuView : UIButton
//初始化方法，设置button打开后一共显示几个button
- (instancetype)initWithTitleArray:(NSArray*)titleArray WithFrame:(CGRect)frame  delegate:(id<IFLYFoldMenuViewDelegate>)delegate;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) CGFloat menuWidth;
@end
