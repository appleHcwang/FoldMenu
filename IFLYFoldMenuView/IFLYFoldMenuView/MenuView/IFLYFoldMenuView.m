//
//  IFLYFoldMenuView.m
//  IFLYFoldMenuView
//
//  Created by admin on 2018/11/24.
//  Copyright © 2018年 admin. All rights reserved.
#import "IFLYFoldMenuView.h"
//修改button之间的间隔
#define INTERVAL  9
@interface IFLYFoldMenuView () {
    NSMutableArray      *_buttonArray;
}
@property (nonatomic,assign)NSInteger buttonCount;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,weak)id<IFLYFoldMenuViewDelegate> delegate;
@end
@implementation IFLYFoldMenuView

- (instancetype)initWithTitleArray:(NSArray*)titleArray WithFrame:(CGRect)frame delegate:(id<IFLYFoldMenuViewDelegate>)delegate  {
    self = [super initWithFrame:frame];
    if (self) {
        self.rect = frame;
        self.buttonCount = titleArray.count;
        self.delegate = delegate;
        self.titleArray = titleArray;
        [self loadSubview];
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//创建子button
- (void)loadSubview {
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:_buttonCount];
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectZero;
        button.tag = i;
        [button addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [_buttonArray addObject:button];
    }
}

- (void)buttonClick:(UIButton *)sender {
    if (!self.isOpen) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
        self.isOpen = YES;
        [self onTheMenu:sender];
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
        self.isOpen = NO;
        [self packUptheMenu:sender];
    }
    //调用delegate方法
    //  [_delegate spreadButton:self clickButtonAtIndex:(int)sender.tag];
}

- (void)subButtonClick:(UIButton *)sender {
    if (!self.isOpen) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
        self.isOpen = YES;
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
        self.isOpen = NO;
    }
    [self packUptheMenu:sender];
    //调用delegate方法
    [_delegate foldMenuView:sender clickButtonAtIndex:(int)sender.tag];
}

- (void)onTheMenu:(UIButton *)sender {
    //初始化子button的位置。
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *but = [_buttonArray objectAtIndex:i];
        [self.superview addSubview:but];
        but.hidden = NO;
        but.frame = CGRectMake(CGRectGetMaxX(self.rect) - self.menuWidth, self.rect.origin.y -  self.menuHeight, self.menuWidth, self.menuHeight);
        but.layer.cornerRadius = CGRectGetHeight(but.frame)/2.f;
        but.layer.masksToBounds = YES;
    }
    //开始展开动画
    [UIView animateWithDuration:0.2 animations:^{
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            [but setTitle:_titleArray[i] forState:UIControlStateNormal];
            but.titleLabel.font = [UIFont systemFontOfSize:13];
            but.frame = CGRectMake(CGRectGetMaxX(self.rect) - self.menuWidth, self.rect.origin.y-(i+1)*(INTERVAL+self.rect.size.height),self.menuWidth, self.menuHeight);
            but.layer.cornerRadius = self.menuHeight/2.f;
            but.layer.masksToBounds = YES;
        }
    }];
}

- (void)packUptheMenu:(UIButton *)sender {
    //收起动画
    [UIView animateWithDuration:0.2 animations:^{
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            but.frame = CGRectMake(CGRectGetMaxX(self.rect) - self.menuWidth, self.rect.origin.y - self.menuHeight, self.menuWidth, self.menuHeight);
        }
    } completion:^(BOOL finished) {
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            but.hidden = YES;
            [but removeFromSuperview];
        }
    }];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIButton *but in _buttonArray) {
        but.backgroundColor = [UIColor blackColor];
    }
}

@end
