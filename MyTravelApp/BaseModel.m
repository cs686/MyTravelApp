//
//  BaseModel.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initContentWithDic:(NSDictionary *)jsonDic {
    self=[super init];
    if (self) {
        [self setAttributes:jsonDic];
    }
    return self;
}

- (void)setAttributes:(NSDictionary *)jsonDic {
    NSDictionary *mapDic =[self attributeMapDictionary:jsonDic];
    for (NSString *jsonKey in mapDic) {
        //modelAttr:"newsId"
        //jsonKey : "id"
        NSString *modelAttr=[mapDic objectForKey:jsonKey];
        SEL selector=[self stringToSel:modelAttr];
        if ([self respondsToSelector:selector]) {
            id value=[jsonDic objectForKey:jsonKey];
            if ([value isKindOfClass:[NSNull class]]) {
                value=@"";
            }
            [self performSelector:selector withObject:value];
        }
    }
}

//将属性名转成SEL类型的set方法
//newsId  --> setNewsId:
- (SEL)stringToSel:(NSString *)attName {
    //截取收字母
    NSString *first = [[attName substringToIndex:1] uppercaseString];
    NSString *end = [attName substringFromIndex:1];
    
    NSString *setMethod = [NSString stringWithFormat:@"set%@%@:",first,end];
    
    //将字符串转成SEL类型
    return NSSelectorFromString(setMethod);
}

/*
 属性名与json字典中key的映射关系
 key:  json字典的key名
 value: model对象的属性名
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    
    return mapDic;
}

@end
