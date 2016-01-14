//
//  NetWorkModel.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "NetWorkModel.h"
#import "AFNetworking.h"

#define BaseURL @""

@implementation NetWorkModel

+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock {
    //拼接URL
    NSString *requestString = [BaseURL stringByAppendingString:urlString];
    requestString=[requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url =[NSURL URLWithString:requestString];
    //网络数据的请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=60;
    request.HTTPMethod=method;
    //参数请求处理
    NSMutableString *paramString=[NSMutableString string];
    NSArray *allKeys=params.allKeys;
    for (NSInteger i=0 ; i<params.count; i++) {
        NSString *key=allKeys[i];
        NSString *value=params[key];
        [paramString appendFormat:@"%@=%@",key,value];
        
        if (i < params.count - 1) {
            [paramString appendString:@"&"];
        }
    }
    
    if ([method isEqualToString:@"GET"]) {
        NSString *seperate = url.query ? @"&" : @"?";
        NSString *paramsURLString = [NSString stringWithFormat:@"%@%@%@",requestString,seperate,paramString];
        
        //根据拼接好的URL进行修改
        request.URL = [NSURL URLWithString:paramsURLString];
        
        
    }
    else if([method isEqualToString:@"POST"]) {
        //POST请求则把参数放在请求体里
        NSData *bodyData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = bodyData;
    }
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            errorblock(connectionError);
            return;
        }
        if (data) {
            //解析JSON数据
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            completionblock(jsonDic);
        }
    }];
}

+ (void)AFRequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock {
    //拼接URL
    urlString = [BaseURL stringByAppendingString:urlString];
    
    //创建管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //GET和POST分别处理
    if ([method isEqualToString:@"GET"]) {
        
        [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completionblock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorblock(error);
        }];
        
        
    }
    else if([method isEqualToString:@"POST"]) {
        [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completionblock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorblock(error);
            
        }];
    }
    
}


//使用multipart-formdata协议上传文件的方法：
//multipart是HTTP协议为web表单新增的上传文件的协议，数据也是放在请求体中，和普通POST的区别是参数不再是key＝value格式，因此特定的数据格式。
+ (void)AFRequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void (^)(id result))completionblock errorHandle:(void (^)(NSError *error))errorblock {
    
    //拼接URL
    urlString = [BaseURL stringByAppendingString:urlString];
    
    //获取管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //{@"pic" : NSData(图片的二进制数据)};
        
        for (NSString *keyName in datas) {
            
            //获取文件的二进制数据
            NSData *data = datas[keyName];
            
            //需要上传的数据添加到formData中
            [formData appendPartWithFileData:data name:keyName fileName:keyName mimeType:@"image/jpeg"];
            
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionblock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorblock(error);
        
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        CGFloat progress = totalBytesWritten / (totalBytesExpectedToWrite * 1.0);
        
        NSLog(@"已上传：%.2f", progress);
        
    }];
    
    
    
    
}


@end
