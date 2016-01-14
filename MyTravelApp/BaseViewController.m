//
//  BaseViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import "HUProgressView.h"

@interface BaseViewController ()
{
    UILabel *_titleLabel;
    BOOL _isHidenTabBar;
    UIView *_hiddenView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    /**
     添加头部标题
     */
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.font=[UIFont systemFontOfSize:15];
   
    self.navigationItem.titleView=_titleLabel;

    /**
     *  添加返回按钮
     */
    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    /**
     *  设置背景色
     */
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg"]];
    //self.view.backgroundColor=[UIColor redColor];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  设置TabBar的隐藏和显示
 */

- (void)viewWillAppear:(BOOL)animated {
    if (_isHidenTabBar) {
        BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
        [tabBar setTabbarHiden:YES];
    } else {
        BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
        [tabBar setTabbarHiden:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    //显示标签栏
    BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
    [tabBar setTabbarHiden:NO];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    _isHidenTabBar=hidesBottomBarWhenPushed;
}

/**
 *  显示进度条
 */

- (void)showProgress {
    //创建遮罩视图
    _hiddenView=[[UIView alloc] initWithFrame:self.view.bounds];
    _hiddenView.backgroundColor = [UIColor colorWithWhite:0 alpha:.2];
    [self.view addSubview:_hiddenView];
    /**
     *  创建进度条
     */
    HUProgressView *progress=[[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    progress.center=_hiddenView.center;
    progress.strokeColor=[UIColor cyanColor];
    [_hiddenView addSubview:progress];
    [progress startProgressAnimating];
    
    UIImageView *horseImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    horseImage.center=_hiddenView.center;
    horseImage.image=[UIImage imageNamed:@"ma"];
    [_hiddenView addSubview:horseImage];
}

- (void)hideProgress {
    [self performSelector:@selector(hideAction) withObject:self afterDelay:0.5];
}
- (void)hideAction {
    [_hiddenView removeFromSuperview];
}

@end
