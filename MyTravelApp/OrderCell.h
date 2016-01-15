//
//  OrderCell.h
//  MyTravelApp
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orderNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *orderCodeLabel;

@property (strong, nonatomic) IBOutlet UILabel *buyDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderTypeLabel;

@property (strong, nonatomic) IBOutlet UILabel *useDataLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UIImageView *orderStateImageView;
@property (strong, nonatomic) IBOutlet UILabel *orderStateLabel;


@property (nonatomic,strong)OrderModel *model;

@end
