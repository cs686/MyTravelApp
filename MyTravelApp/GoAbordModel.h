//
//  GoAbordModel.h
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GoAbordModel : BaseModel


@property (nonatomic, copy) NSString *package_explain;

@property (nonatomic, copy) NSString *setup_city;

@property (nonatomic, copy) NSString *tours_type;

@property (nonatomic, copy) NSString *is_self_drive;//是否为自驾游

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *spend_time;

@property (nonatomic, copy) NSString *minus_amount;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *is_train;

@property (nonatomic, copy) NSString *group_type;

@property (nonatomic, copy) NSString *juntu_price;

@property (nonatomic, copy) NSString *baby_price;

@property (nonatomic, strong) NSArray *images;//展示图

@property (nonatomic, copy) NSString *production_no;

@property (nonatomic, copy) NSString *least_buy_quantity;

@property (nonatomic, copy) NSString *most_buy_quantity;

@property (nonatomic, copy) NSString *is_deal;

@property (nonatomic, copy) NSString *offered_nature;

@property (nonatomic, copy) NSString *myId;

@property (nonatomic, copy) NSString *is_sales_by_package;

@property (nonatomic, copy) NSString *travel_date;

@property (nonatomic, copy) NSString *features;

@property (nonatomic, copy) NSString *myDescription;

@end



