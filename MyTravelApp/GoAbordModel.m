//
//  GoAbordModel.m
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "GoAbordModel.h"

@implementation GoAbordModel

- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    NSMutableDictionary *mapDic=[NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"myId" forKey:@"id"];
    [mapDic setObject:@"myDescription" forKey:@"description"];
    return mapDic;
}

@end


