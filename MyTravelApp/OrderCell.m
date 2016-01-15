//
//  OrderCell.m
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)setModel:(OrderModel *)model {
    if (_model != model) {
        _model=model;
        if ([_model.order_type isEqualToString:@"hotel"]) {
            _orderNameLabel.text=_model.hotel_name;
        } else if ([_model.order_type isEqualToString:@"dest"]) {
            _orderNameLabel.text=_model.order_name;
        } else if ([_model.order_type isEqualToString:@"tours"]) {
            _orderNameLabel.text=_model.product_name;
        }
        
        
        _orderCodeLabel.text=_model.order_id;
        //时间戳的转换
        //_buyDataLabel.text=[self ]
        _priceLabel.text=[NSString stringWithFormat:@"%@",_model.total];
        
        if ([_model.order_status isEqualToNumber:@2] || [_model.order_status isEqualToNumber:@4]) {
            _orderStateImageView.image=[UIImage imageNamed:@"qufukuan"];
        } else if ([_model.order_status isEqualToNumber:@3]) {
            _orderStateImageView.image=[UIImage imageNamed:@"yiquxiao"];
        }
        
        _orderStateLabel.text=_model.order_status_name;
        
        
        //订单类型决定的出游或者入住label
        if ([_model.order_type isEqualToString:@"hotel"]) {
            _orderTypeLabel.text = @"入住日期";
            //入住日期
            _useDataLabel.text = [self convertTime:_model.travel_date];
        }else if ([_model.order_type isEqualToString:@"dest"]){
            _orderTypeLabel.text = @"有 效 期";
            //有效期
            _useDataLabel.text = [NSString stringWithFormat:@"%@至%@",[self convertTime:_model.travel_start_date],[self convertTime:_model.to_date]];
        }else if ([_model.order_type isEqualToString:@"route"]){
            _orderTypeLabel.text = @"出游日期";
            //出游日期
            _useDataLabel.text = [self convertTime:_model.travel_date];
        }
        
        
        
    }
}

- (NSString*)convertTime:(NSString *)timeString {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *formateDate=[formater stringFromDate:date];
    return formateDate;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
