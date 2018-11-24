//
//  ViewController.m
//  IFLYFoldMenuView
//
//  Created by admin on 2018/11/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    NSArray             *_titleArray;
    BOOL                 _isHorizontal;
    IFLYFoldMenuView        *_IFLYFoldMenuView;
    UILabel * titleLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"demo";
    _titleArray = @[@"写医嘱",@"写病历",@"发起会诊",@"写备注"];
    self.view.backgroundColor = [UIColor whiteColor];
    _IFLYFoldMenuView = [[IFLYFoldMenuView alloc] initWithTitleArray:_titleArray WithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 65, CGRectGetHeight(self.view.frame) - 90, 50, 50) delegate:self];
    _IFLYFoldMenuView.menuWidth = 72.f;
    _IFLYFoldMenuView.menuHeight = 40.f;
    _IFLYFoldMenuView.titleArray = _titleArray;
    _IFLYFoldMenuView.backgroundColor = [UIColor clearColor];
    [_IFLYFoldMenuView setBackgroundImage:[UIImage imageNamed:@"cicle"] forState: UIControlStateNormal];
    [self.view addSubview:_IFLYFoldMenuView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)foldMenuView:(UIButton *)button clickButtonAtIndex:(int)index {
    titleLabel.text = button.titleLabel.text;
}


@end
