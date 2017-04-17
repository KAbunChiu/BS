//
//  KABINNetworkTool.m
//  RuleBaby
//
//  Created by KAbun on 16/12/9.
//  Copyright © 2016年 KABIN. All rights reserved.
//

#import "KABINNetworkTool.h"
@implementation KABINNetworkTool

//get请求
+(void)GET:(NSString *)URL params:(NSDictionary *)params progress:(void (^)(NSProgress *))downloadProgressBlock success:(void (^)(NSURLSessionDataTask *, id))success failuer:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //1.创建请求管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    //设置请求数据格式为data，如果不设置这段代码默认返回的是字典或者数组
//    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval=20;
   
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    //2.发送请求
    [manager GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            //获取响应头
            success(task,responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
}

+(void)POST:(NSString *)URL params:(NSDictionary *)parames progress:(void (^)(NSProgress *))uploadProgressBlock success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    //1.创建请求管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //设置请求数据格式话为data,如果不设置这段代码默认返回的是字典或数组
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.requestSerializer.timeoutInterval=20;
     [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    // 2. 发送请求
    [manager POST:URL parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
}


+(void)PUT:(NSString *)URL params:(id)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    // 1. 创建请求管理者
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    // 设置请求数据格式话为data，如果不设置这段代码默认返回的是字典或数组
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval=20;
     [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    // 2. 发送请求
    [manager PUT:URL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task,error);
        }
    }];
    
}

+(void)DELETE:(NSString *)URL params:(id)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    // 1. 创建请求管理者
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    // 设置请求数据格式话为data，如果不设置这段代码默认返回的是字典或数组
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   manager.requestSerializer.timeoutInterval=20;
     [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    // 2. 发送请求
    [manager DELETE:URL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}


+(void)downLoad:(NSString *)urlString progress:(void (^)(NSProgress *))downloadProgressBlock destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler{

    // 1. 创建
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.确定请求URL地址
    NSURL *URL = [NSURL URLWithString:urlString];
    // 3. 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 必须有返回值才能
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response, filePath, error);
        }
    }];
    // 开始任务
    [task resume];
}

+ (void)stopLoadNetwork
{
    // 1. 创建请求管理者
    //    BLLog(@"停止了网络请求");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}


+(AFSecurityPolicy*)customSecurityPolicy{
    NSString *cerPath=[[NSBundle mainBundle] pathForResource:@"guibaoB" ofType:@"cer"];
    
    NSData *cerData=[NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //GBLog(@"**************************%@",cerData);
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates=YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
  
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    NSSet *set=[[NSSet alloc]initWithObjects:cerData, nil];
    
    securityPolicy.pinnedCertificates = set;
    
    
    return securityPolicy;
}

@end
