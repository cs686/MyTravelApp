//
//  OrderModel.h
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface OrderModel : BaseModel

@property (nonatomic,copy) NSString *to_date;//有效期截止
@property (nonatomic,copy) NSString *travel_start_date;//有效期开始

@property (nonatomic,copy) NSString *product_name;//订单名称(路线)
@property (nonatomic,copy) NSString *order_name;//订单名称（景区）
@property (nonatomic, copy) NSString *total;//价格
@property (nonatomic, copy) NSString *order_status_name;//订单状态名字
@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSNumber* order_status;

@property (nonatomic, copy) NSString *hotel_name;

@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *travel_date;
@property (nonatomic, copy) NSString *order_type;


@end
