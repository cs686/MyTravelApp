//
//  MyImageView.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "MyImageView.h"
#import "BaseNavigationController.h"
#import "UIView+UIViewController.h"
#import "WebViewController.h"

@implementation MyImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        //可以接受点击事件
        self.userInteractionEnabled=YES;
    }
    return  self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog( @"点击网页事件");
    WebViewController *webView=[[WebViewController alloc] init];
    webView.showTitle=@"我的旅游";
    webView.urlString=self.urlString;
    BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:webView];
    [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
