//
//  GoAbordViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "GoAbordViewController.h"
#import "NetWorkModel.h"
#import "GoAbordModel.h"
#import "GoAbordView.h"

@implementation GoAbordViewController {
    UITableView *_tableView;
    GoAbordView *_headView;//tableView的头视图
    GoAbordModel *_headModel;
    UIImageView *_lineView;
    UIWebView  *_showWeb;
    NSURLRequest *_request;
    NSString *_endString;
    
    int height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"出游详情";
    //加载数据
    [self loadData];
    //创建网页视图
    [self createWebView];
    //创建tableView
    [self createTableView];
    //创建电话购买
}

- (void)loadData {
    [self showProgress];
    NSString *string =kDetail;
    NSString *urlString=[string stringByAppendingString:self.idStr];
    [NetWorkModel requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        NSArray *tourArray=result[@"tourShow"];
        NSDictionary *tourDic=[tourArray lastObject];
        //多线程处理
        dispatch_async(dispatch_get_main_queue(), ^{
            GoAbordModel *headModel=[[GoAbordModel alloc] initContentWithDic:tourDic];
            _headView.model=headModel;
            [_tableView reloadData];
            [self hideProgress];
        });
    } errorHandle:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)createTableView {
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _headView=[[[NSBundle mainBundle] loadNibNamed:@"GoAbordView" owner:self options:nil]lastObject];
    _headView.frame=CGRectMake(0, 0, ScreenWidth, 250);
    _tableView.tableHeaderView=_headView;
}

- (void)createWebView {
    _endString=[NSString stringWithFormat:@"%@&client_type=3",self.idStr];
    NSString *urlString =[kStrokeD stringByAppendingString:_endString];
    
    //加载网页视图
    
    _showWeb=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-150)];
    _showWeb.delegate=self;
    _showWeb.backgroundColor=[UIColor whiteColor];
    _request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_showWeb loadRequest:_request];
}

- (void)creatBottomView {
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    bottomView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"juntu_2_7"]];
    [self.view addSubview:bottomView];
    
    UIButton *phoneButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 8, ScreenWidth/2-40, 30)];
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 10, 8, ScreenWidth/2 - 10, 30)];
    [bottomView addSubview:phoneButton];
    [bottomView addSubview:buyButton];
    
    [phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"zixun_normal—111"] forState:UIControlStateNormal];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"zixun_normal2x"] forState:UIControlStateNormal];
}

#pragma mark-webView的代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURLCache *cache=[NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    [_showWeb stopLoading];
}

#pragma mark-tableView代理设置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else {
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 35;
    }else{
        return ScreenHeight-150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cid=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    
    if (indexPath.section==0) {
        //添加日历图标
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, 20, 20)];
        imageView.image=[UIImage imageNamed:@"rili12x"];
        UILabel *riliLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 2.5, 150, 30)];
        //选择日期
        riliLabel.text=@"请选择出发日期";
        riliLabel.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:riliLabel];
        [cell.contentView addSubview:imageView];
        //
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 2.5, 100,30)];
        timeLabel.text=_headModel.travel_date;
        timeLabel.font=[UIFont systemFontOfSize:14];
        timeLabel.textAlignment=NSTextAlignmentCenter;
        timeLabel.textColor=[UIColor greenColor];
        [cell.contentView addSubview:timeLabel];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section==1) {
        [cell.contentView addSubview:_showWeb];
    }
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        UIView *sectionView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        //添加4个button
        NSArray *array=@[@"行程介绍",@"线路特色",@"费用说明",@"重要提示"];
        CGFloat buttonWidth=ScreenWidth/4;
        for (int i=0; i<array.count; i++) {
            UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, 33)];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.backgroundColor =[UIColor whiteColor];
            button.titleLabel.textAlignment=NSTextAlignmentCenter;
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button setTintColor:[UIColor blackColor]];
            [button addTarget:self action:@selector(selecteButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag=i+200;
            [sectionView addSubview:button];
        }
        //添加下划线
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 33, buttonWidth-10, 2)];
        _lineView.backgroundColor = [UIColor colorWithRed:50/255.0 green:184/255.0 blue:190/255.0 alpha:1];
        [sectionView addSubview:_lineView];
        
        return sectionView;
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        NSLog( @"日历");
    }
}

//为四个button添加方法
- (void)selecteButton:(UIButton*)button {
    NSInteger index=button.tag-200;
    //点击添加动画
    [UIView animateWithDuration:.3 animations:^{
        _lineView.transform=CGAffineTransformMakeTranslation(index*ScreenWidth/4, 0);
    }];
    
    NSString *urlString;
    
    switch (index) {
        case 0://形成介绍
            urlString=[kStrokeD stringByAppendingString:_endString];
            break;
        case 2://费用说明
            urlString=[kFeeD stringByAppendingString:_endString];
            break;
        case 3://重要说明
            urlString=[kNoticeD stringByAppendingString:_endString];
            break;
        default:
            break;
    }
    
    _request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_showWeb stopLoading];
    [_showWeb loadRequest:_request];
    //线路特色
    if (index==1) {
        CGFloat fontSize=14;
        NSString *fontColor = @"Gray";
        NSString *text=[_headModel.features stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        NSString *jsString=[NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size: %f; color: %@;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>%@</body> \n"
                            "</html>",fontSize,fontColor,text];
        [_showWeb loadHTMLString:jsString baseURL:nil];
    }
    _showWeb.scrollView.delegate=self;
}

//webView拉到顶部时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offY = _showWeb.scrollView.contentOffset.y;
    if (offY <0) {
        _showWeb.scrollView.contentOffset = CGPointMake(0, 0);
        CGPoint offSet = CGPointMake(0, -64);
        [UIView animateWithDuration:.5 animations:^{
            _tableView.contentOffset = offSet;
        }];
    }
}

@end
