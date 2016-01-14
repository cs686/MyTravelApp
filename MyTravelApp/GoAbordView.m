//
//  GoAbordView.m
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "GoAbordView.h"

@implementation GoAbordView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}

- (void)setModel:(GoAbordModel *)model {
    if (_model != model) {
        _model = model;
        
        //标题
        _titleLabel.text = _model.title;
        //编号
        _production_noLabel.text = [NSString stringWithFormat:@"编号:%@",_model.production_no];
        
        //出发地
        _setup_cityLabel.text = [NSString stringWithFormat:@"出发地:%@",_model.setup_city];
        //天数
        _spend_timeLabel.text = [NSString stringWithFormat:@"行程:%@天",_model.spend_time];
        
        //价格
        CGFloat price = [_model.juntu_price floatValue];
        _juntu_priceLabel.text = [NSString stringWithFormat:@"¥%.f",price];
        
        //图片数据处理
        NSArray *imageArray = _model.images;
        //照片数量
        _imagesCount.text = [NSString stringWithFormat:@"%li张",imageArray.count];
        
        NSMutableArray *urlArray = [NSMutableArray array];
        for (NSDictionary *dic in imageArray) {
            NSString *urlString = dic[@"url"];
            [urlArray addObject:urlString];
        }
        
        //设置图片
        NSURL *url = [NSURL URLWithString:urlArray[0]];
        [_headBigImageView sd_setImageWithURL:url];    }
}

@end
