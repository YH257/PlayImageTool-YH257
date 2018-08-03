//
//  XDNetRequestClass.h
//  PointRaceStone
//
//  Created by fdinc01 on 2018/5/11.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFHTTPSessionManager;
@interface XDNetRequestClass : NSObject

#pragma mark -监听网络

+(void) netWorkReachabilityBlock:(void(^)(BOOL netConnetState))block;

+(AFHTTPSessionManager *)manager;

#pragma POST请求
+(void)NetRequestPOSTWithURL:(NSString *)requestUrlString withParameter:(NSDictionary *)parameter success:(void(^)(id returnValue))block failure:(void(^)(id errorCode))failureBlock;

#pragma POST请求
+(void)NetRequestPOSTWithPayURL:(NSString *)requestUrlString withParameter:(NSDictionary *)parameter success:(void(^)(id returnValue))block failure:(void(^)(id errorCode))failureBlock;


#pragma GET请求
+(void)NetRequestGETWithURL:(NSString *)requestUrlString withParameter:(NSDictionary *)parameter success:(void (^)(id returnValue))block failure:(void(^)(id errorCode))failureBlock;




#pragma 下载文件
+ (void)downLoadWithUrlString:(NSString *)urlString;

#pragma 上传文件
+ (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg;




@end
