//
//  GoAbordView.h
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoAbordModel.h"

@interface GoAbordView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *headBigImageView;
@property (strong, nonatomic) IBOutlet UILabel *production_noLabel;
@property (strong, nonatomic) IBOutlet UILabel *spend_timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *imagesCount;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *setup_cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *juntu_priceLabel;

@property (nonatomic,strong) GoAbordModel *model;

@end
