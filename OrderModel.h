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




@property (nonatomic, copy) NSString *total;//价格
@property (nonatomic, copy) NSString *order_status_name;//订单状态名字
@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger order_status;

@property (nonatomic, copy) NSString *hotel_name;

@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *travel_date;
@property (nonatomic, copy) NSString *order_type;


@end
