//
//  TabBarButton.h
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

@property (nonatomic,strong)UIImageView *myImageView;
@property (nonatomic,strong)UILabel *label;

/**
 *  按钮的初始化方法
 *
 *  @param title     按钮标题
 *  @param imageName 图片
 *  @param frame     大小
 *
 */

- (id)initWithTitle:(NSString*)title
          imageName:(NSString*)imageName
              frame:(CGRect)frame;

@end
