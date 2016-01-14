//
//  GoAbordViewController.h
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GoAbordViewController :BaseViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,copy)NSString *idStr;


@end
