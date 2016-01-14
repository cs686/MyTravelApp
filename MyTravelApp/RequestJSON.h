//
//  RequestJSON.h
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestJSON : NSObject

+ (id)loadData:(NSString *)file;
//加载网络数据
+ (id)loadDataInternet:(NSString *)http;

@end
