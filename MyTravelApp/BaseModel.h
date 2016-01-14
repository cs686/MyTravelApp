//
//  BaseModel.h
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
/**
 *  数据解析
 *
 *  @param jsonDic
 *
 *  @return 
 */
- (id)initContentWithDic:(NSDictionary *)jsonDic;
-(void)setAttributes:(NSDictionary*)jsonDic;
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;

@end
