//
//  MyOrderViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    UITableView *_tableView;
    NSArray *_orderData;
}

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.navigationItem.leftBarButtonItem = nil;
    [self createTableView];
}

- (void)createTableView {
    _orderData=@[@"酒店订单",@"景区订单",@"旅游路线订单",@"景加酒订单",@"门加门订单",@"套票订单",@"体验团订单"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 372)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cid=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    cell.textLabel.text=_orderData[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%li",indexPath.row);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *userId=[defaults objectForKey:kUserID];
    if (userId==nil) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"你还没有登陆" message:@"请登录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.delegate=self;
        [alertView show];
    } else {
        
        
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
