//
//  TabBarButton.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton


- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        //设置按钮图片的位置
        _myImageView=[[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-20)/2, 8, 22, 20)];
        _myImageView.image=[UIImage imageNamed:imageName];
        [self addSubview:_myImageView];
        
        _myImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        _label=[[UILabel alloc] initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        _label.text=title;
        _label.font=[UIFont systemFontOfSize:10];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=[UIColor grayColor];
        [self addSubview:_label];
    }
    return self;
}


@end
