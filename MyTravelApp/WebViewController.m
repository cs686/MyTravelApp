//
//  WebViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "WebViewController.h"
#import "RegexKitLite.h"
#import "GoAbordViewController.h"


@implementation WebViewController{
    UIWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title=_showTitle;
    //设置返回按钮
    UIButton *leftBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftBtn setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    [self createWebView];
    
}
- (void)leftButtonAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
//创建网页视图

- (void)createWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    if (self.urlString!=nil) {
        NSURL *url=[NSURL URLWithString:self.urlString];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    } else {
        [_webView loadHTMLString:self.showContent baseURL:nil];
    }
    _webView.delegate=self;
    [self.view addSubview:_webView];
}


/*
#pragma mark- webView的delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //获取点击位置的URL
    NSString *urlString=request.URL.absoluteString;
    //使用正则表达式取出id
    NSString *regx=@"\\b\\d{4}\\b";
    NSArray *array=[urlString componentsSeparatedByString:regx];
    if (array.count>0) {
        GoAbordViewController *goAbord=[[GoAbordViewController alloc] init];
        goAbord.idStr=array[0];
        goAbord.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goAbord animated:YES];
    }
    return YES;
}
*/

@end
