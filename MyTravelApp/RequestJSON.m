//
//  RequestJSON.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "RequestJSON.h"

@implementation RequestJSON

+ (id)loadData:(NSString *)file{
    NSString *path=[[NSBundle mainBundle]pathForResource:file ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    id json=[NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableLeaves
                                              error:nil];
    return json;
}
//加载网络数据
+ (id)loadDataInternet:(NSString *)http{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:http]];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    id json=[NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableLeaves
                                              error:nil];
    return json;
}

@end
