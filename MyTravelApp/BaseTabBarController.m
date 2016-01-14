//
//  BaseTabBarController.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"

#define Bcolor [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1]

@interface BaseTabBarController (){
    UIView *_newTabBar;
    NSMutableArray *_btnArray;
    NSMutableArray *_selectedImages;
    NSMutableArray *_normalImages;
}
@end

@implementation BaseTabBarController

- (void)setTabbarHiden:(BOOL)isHidden {
    _newTabBar.hidden=isHidden;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btnArray=[NSMutableArray array];
    _selectedImages=[NSMutableArray array];
    _normalImages=[NSMutableArray array];
    
    for (int i=0; i<4; i++) {
        UIImage *selectImage=[UIImage imageNamed:[NSString stringWithFormat:@"图标a%d",i+11]];
        UIImage *normalImage=[UIImage imageNamed:[NSString stringWithFormat:@"图标a%d",i+1]];
        [_selectedImages addObject:selectImage];
        [_normalImages addObject:normalImage];
    }
    
    [self createTabBar];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)createTabBar {
    _newTabBar =[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    _newTabBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1_4"]];
    [self.view addSubview:_newTabBar];
    
    //按钮的宽度
    CGFloat buttonWidth=ScreenWidth/4;
    NSArray *nameArray =@[@"首页",@"我的订单",@"我的旅行",@"联系我们"];
    for ( int i=0; i<4; i++) {
        TabBarButton *button =[[TabBarButton alloc] initWithTitle:nameArray[i] imageName:[NSString stringWithFormat:@"图标a%d",i+1] frame:CGRectMake(buttonWidth*i, 0, buttonWidth, 49)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+100;
        [_newTabBar addSubview:button];
        [_btnArray addObject:button];
        if (i==0) {
            button.label.textColor=Bcolor;
            button.imageView.image=_selectedImages[0];
        }
    }
}

- (void)buttonAction:(TabBarButton*)button {
    NSInteger index=button.tag-100;
    self.selectedIndex=index;
    if (index==3) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"400-400-400" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
    }
    
    for ( int i=0; i<4; i++) {
        if (index==i) {
            continue;
        } else {
            TabBarButton *btn=_btnArray[i];
            btn.label.textColor=[UIColor grayColor];
            btn.myImageView.image=_normalImages[i];
        }
    }
    
    button.label.textColor=Bcolor;
    button.myImageView.image=_selectedImages[index];
    
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
