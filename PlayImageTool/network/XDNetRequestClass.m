//
//  XDNetRequestClass.m
//  PointRaceStone
//
//  Created by fdinc01 on 2018/5/11.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import "XDNetRequestClass.h"
#import "AFNetworking.h"
#import "RequestUrlCommon.h"
#import "AFHTTPSessionManager.h"
#import "RequestUrlCommon.h"


static NSString * const noNetworkStr = @"暂无网络";

@implementation XDNetRequestClass

#pragma mark -监听网络
+(void)netWorkReachabilityBlock:(void(^)(BOOL netConnetState))block{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                block(YES);
                //netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //netState = NO;
                block(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                block(YES);
                //netState = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //netState = YES;
                block(YES);
                break;
            default:
                break;
        }
    }];
}

+(AFHTTPSessionManager *)manager
{
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/", XDAppCommentUrl]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    return manager;
}




#pragma POST请求
+(void)NetRequestPOSTWithURL:(NSString *)requestUrlString withParameter:(NSDictionary *)parameter success:(void(^)(id returnValue))block failure:(void(^)(id errorCode))failureBlock{
    
    
    if (!requestUrlString) {
        requestUrlString = @"";
    }
    [XDNetRequestClass netWorkReachabilityBlock:^(BOOL netConnetState) {
        if (!netConnetState) {
            failureBlock(noNetworkStr);
        }
    }];
    
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:requestUrlString
       parameters:parameter
         progress:^(NSProgress * _Nonnull uploadProgress) {
             // 这里可以获取到目前数据请求的进度
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功
             if(responseObject){
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 NSNumber *statusCode = [dict objectForKey:@"statusCode"];
                 //token 失效 (当账号被踢下线时，主动调自己的服务器返回）
                 if ([statusCode integerValue] == 40111011) {
                     return ;
                 }
                 block(dict);
             } else {
                 block(@{@"msg":@"暂无数据"});
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败
             failureBlock(error);
         }];
}




#pragma GET请求
+(void)NetRequestGETWithURL:(NSString *)requestUrlString withParameter:(NSDictionary *)parameter success:(void (^)(id returnValue))block failure:(void(^)(id errorCode))failureBlock{
    
//    [XDNetRequestClass netWorkReachabilityBlock:^(BOOL netConnetState) {
//        if (!netConnetState) {
//            failureBlock(noNetworkStr);
//        }
//    }];
    
   
    requestUrlString=@"";
    
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    [manager GET:requestUrlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(responseObject){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                block(dict);
            } else {
                block(@{@"msg":@"暂无数据"});
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failureBlock(error);
    }];
}



@end
