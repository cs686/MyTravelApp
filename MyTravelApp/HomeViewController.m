//
//  HomeViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "NetWorkModel.h"
#import "MyImageView.h"
#import "MainCollectionView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIButton+WebCache.h"
#import "WebViewController.h"
#import "BaseNavigationController.h"
#import "GoAbordViewController.h"

#import "RegexKitLite.h"
//下拉刷新第三方库
#import "MJRefresh.h"
#import "MJDIYHeader.h"

#define Bcolor [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1]

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIWebViewDelegate>
{
    UIScrollView *_scrollView;
    NSArray *_scrollViewData;//头部图片轮播数据
    UIPageControl *_pageControll;
    UIImageView *_leftImgView;//导航栏图标
    UITableView *_tableView;
    NSURLRequest *_request;//网页请求
    UIWebView *_showWeb;//加载网页
    NSArray *_fourButtonData;//推荐4个
    NSTimer *_timer;
    
    UIButton *_outboundButton;//出境游
    UIButton *_domesticButton;//错峰游
    UIView *_buttonLine;//选中按钮的下划线
}

@end

@implementation HomeViewController
/**
 *  设置自动滚动时间
 */
- (void)viewDidAppear:(BOOL)animated {
    [_timer invalidate];
    _pageControll.currentPage=0;
    _scrollView.contentOffset=CGPointMake(0, 0);
    [self startTimerAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建导航栏
    [self createNav];
    //加载数据
    [self loadData];
    //加载表
    [self createTableView];
}

- (void)createNav {
    _leftImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white2x"]];
    
    _leftImgView.frame=CGRectMake(0, 0, 37, 23);
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc] initWithCustomView:_leftImgView];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    //设置导航栏搜索框，点击进入搜索页面
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=titleView.frame;
    [btn setTitle:@"搜索酒店、景点" forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn setBackgroundImage:[UIImage imageNamed:@"1136_menu_btn_sousuotiao"] forState:UIControlStateNormal];
    btn.layer.cornerRadius=10;
    btn.layer.masksToBounds=YES;
    [titleView addSubview:btn];
    [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:titleView];
}

- (void)searchAction {
    SearchViewController *search=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)loadData {
    NSString *urlString=@"http://www.juntu.com/index.php?m=app&c=index&a=index_focus&version=1.3";
    //网络请求，使用多线程
    [NetWorkModel requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        //轮播窗口的数据
        _scrollViewData=result[@"subject"];
        _fourButtonData=result[@"recommend"];
        //多线程使用
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
            [_tableView reloadData];
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error");
    }];
}

#pragma mark - 表示图的构建
- (void)createTableView {
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    //下拉刷新
    _tableView.header=[MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    
    //设置网页视图
    _showWeb =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-130)];
    _request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_left"]];
    _showWeb.delegate=self;
    _showWeb.scrollView.delegate=self;
    _showWeb.backgroundColor=[UIColor clearColor];
    [_showWeb loadRequest:_request];
}
- (void)refreshAction {
    NSLog(@"下拉刷新");
    _scrollViewData=nil;
    _fourButtonData=nil;
    [self loadData];
}
#pragma mark-设置轮播时间
- (void)startTimerAction {
    _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}
- (void)timeAction {
    if (_pageControll.currentPage == _scrollViewData.count-1) {
        _pageControll.currentPage=0;
        _scrollView.contentOffset=CGPointMake(_pageControll.currentPage*ScreenWidth, 0);
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            _pageControll.currentPage++;
            _scrollView.contentOffset=CGPointMake(_pageControll.currentPage*ScreenWidth, 0);
        }];
    }
}

#pragma mark -tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 0;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 400;
    }else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight-130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section==1) {
        [cell.contentView addSubview:_showWeb];
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 400)];
        
        //添加滑动视图
        
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        _scrollView.contentSize=CGSizeMake(ScreenWidth*_scrollViewData.count, 150);
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        //插入图片
        for ( int i=0; i<_scrollViewData.count; i++) {
            NSDictionary *dic=_scrollViewData[i];
            NSString *imageUrl=dic[@"thumb"];
            NSString *linkUrl=dic[@"linkurl"];
            MyImageView *imageView=[[MyImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, 150)];
            imageView.urlString=linkUrl;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"384"]];
            [_scrollView addSubview:imageView];
        }
        [view addSubview:_scrollView];
        
        //添加分页控制
        _pageControll =[[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth/4, 135, ScreenWidth/2, 15)];
        _pageControll.numberOfPages=_scrollViewData.count;
        _pageControll.currentPage=0;
        [view addSubview:_pageControll];
        
        //collectionView添加轮播图片
        NSString *filePath=[[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"];
        NSArray *imageData=[NSArray arrayWithContentsOfFile:filePath];
        NSArray *imageNames=@[@"btnTop8_1",@"btnTop8_2",@"btnTop8_3",@"btnTop8_4",@"btnTop8_5",@"btnTop8_6",@"btnTop8_7",@"btnTop8_8"];
        NSArray *titles=@[@"景点门票",@"出境游",@"国内游",@"天天特价",@"西安周边游",@"度假酒店",@"景加酒",@"自驾游"];
        MainCollectionView *mainCollectionView=[[MainCollectionView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 150) titles:titles imageData:imageData imageNames:imageNames];
        mainCollectionView.backgroundColor=[UIColor whiteColor];
        [view addSubview:mainCollectionView];
        
        //四个模块的高度
        CGFloat width=ScreenWidth / 2;
        CGFloat height=45;
        //使用循环简历推荐模块
        for ( int i=0; i<2; i++) {
            for (int j=0; j<2; j++) {
                int index= i*2 + j;
                UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(j*(width +2), i*(height +2)+305, width-1, height-1)];
                NSDictionary *dic=_fourButtonData[index];
                NSString *urlString=dic[@"thumb"];
                [button sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
                [button addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                button.tag=index+100;
                button.backgroundColor=[UIColor whiteColor];
                [view addSubview:button];
            }
        }
        return view;
    } else {
        UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        //添加出境游和国内游按钮
        _outboundButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth/2, 28)];
        [_outboundButton setTitle:@"出境游" forState:UIControlStateNormal];
        [_outboundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _outboundButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_outboundButton setTitleColor:Bcolor forState:UIControlStateSelected];
        _outboundButton.backgroundColor=[UIColor whiteColor];
        [_outboundButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _outboundButton.tag=100;
        _outboundButton.selected=YES;
        
        _domesticButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2 , 1, ScreenWidth/2, 28)];
        [_domesticButton setTitle:@"国内错峰游" forState:UIControlStateNormal];
        _domesticButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_domesticButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_domesticButton setTitleColor:Bcolor forState:UIControlStateSelected];
        _domesticButton.backgroundColor = [UIColor whiteColor];
        [_domesticButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _domesticButton.tag = 101;
        [headView addSubview:_outboundButton];
        [headView addSubview:_domesticButton];
        
        //添加下划线
        _buttonLine=[[UIView alloc] initWithFrame:CGRectMake(10, 28, ScreenWidth/2-20, 2)];
        _buttonLine.backgroundColor=Bcolor;
        [headView addSubview:_buttonLine];
        return headView;
    }
}

#pragma mark-scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat moveDic=scrollView.contentOffset.y;
    if (moveDic>0) {
        _leftImgView.image=[UIImage imageNamed:@"组合3"];
    } else {
        _leftImgView.image=[UIImage imageNamed:@"logo_white2x"];
    }
    
    //设置当前页面
    NSInteger offset=scrollView.contentOffset.x;
    NSInteger page=offset/ScreenWidth;
    _pageControll.currentPage=page;
    //使webview和tableView连一起
    CGFloat offY=_showWeb.scrollView.contentOffset.y;
    if (offY<0) {
        _showWeb.scrollView.contentOffset=CGPointMake(0, 0);
        CGPoint offset=CGPointMake(0, -64);
        [UIView animateWithDuration:.5 animations:^{
            _tableView.contentOffset=offset;
        }];
    }
    
}

#pragma mark-出境游和国内游按钮点击事件

- (void)buttonAction:(UIButton *)button {
    if (button.tag==100) {
        _request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_left"]];
        
        _outboundButton.selected=YES;
        _domesticButton.selected=NO;
        [UIView animateWithDuration:.2 animations:^{
            _buttonLine.transform=CGAffineTransformIdentity;
        }];
    } else if (button.tag==101) {
        _request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_right"]];
        _outboundButton.selected=NO;
        _domesticButton.selected=YES;
        [UIView animateWithDuration:.2 animations:^{
            _buttonLine.transform = CGAffineTransformMakeTranslation(ScreenWidth/2, 0);
        }];
    }
    
    [_showWeb loadRequest:_request];
}

#pragma mark-推荐按钮的点击事件

- (void)fourButtonAction:(UIButton *)button {
    NSInteger index=button.tag-100;
    NSDictionary *dic=_fourButtonData[index];
    NSString *urlString=dic[@"linkurl"];
    
    //添加webView
    
    WebViewController *webView=[[WebViewController alloc] init];
    webView.urlString=urlString;
    webView.showTitle=dic[@"name"];
    BaseNavigationController *navWeb=[[BaseNavigationController alloc] initWithRootViewController:webView];
    [self.navigationController presentViewController:navWeb animated:YES completion:nil];
    
}

#pragma  mark-WebView的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString=request.URL.absoluteString;
    NSString *regx=@"\\b\\d{4}\\b";
    NSArray *array=[urlString componentsSeparatedByString:regx];
    
    /**
     *  此处有问题
     */
    
    if (array.count>0) {
        GoAbordViewController *goAboard =[[GoAbordViewController alloc] init];
        goAboard.idStr=array[0];
        goAboard.hidesBottomBarWhenPushed=YES;
        //[self.navigationController pushViewController:goAboard animated:YES];
    }
     
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURLCache *cache=[NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
