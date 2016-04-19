//
//  ServerRequestManager.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/21.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ServerRequestManager.h"
#import "AppDefine.h"
#import "NetworkingUtil.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation ServerRequestManager

+(instancetype)shared
{
    static ServerRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(NSString *)dataToJsonString:(id)object
{
    NSString *JsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        NSLog(@"Got an error %@",error);
    }else{
        JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return JsonString;
}

+(id)JsonStringToData:(NSString *)jsonString
{
    if(! jsonString.length)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if(jsonObject != nil && error == nil)
    {
        return jsonObject;
    }
    else
    {
        //解析错误
        return nil;
    }
}

-(void)requestWithParameter:(NSDictionary *)parameters method:(NSString *)method successed:(void(^)(NSDictionary *resultDic))successed failed:(void(^)(NSDictionary *errorDic))failed
{
    if (![NetworkingUtil isConnectionAvailable]) {
        NSDictionary *dic = @{@"error":@"-111",@"message":@"网络不可用"};
        failed(dic);
        return;
    }
    
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    NSString *postUrl = [[NSString stringWithFormat:@"%@%@",kServerURL,method] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *param = [parameters mutableCopy];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:postUrl parameters:param error:nil];
    [request setTimeoutInterval:60];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
            NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            //返回字符格式处理
            NSData *data = [resultString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            successed(resultDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *string = @"网络状态不好";
        NSDictionary *dic = @{@"error":[NSString stringWithFormat:@"%zd",error.code],@"message":string};
        failed(dic);
    }];
    //开始请求
    [operation start];
}


-(void)getUserInfoWithUid:(NSString *)uid name:(NSString *)screenName RequestWithSuccessed:(void (^)(NSDictionary *))successed failed:(void (^)(NSDictionary *))failed
{
    if (uid == nil && screenName == nil) {
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:1];
    if (uid != nil) {
        [parameters setObject:uid forKey:@"uid"];
    }
    if (screenName != nil) {
        [parameters setObject:screenName forKey:@"screen_name"];
    }
    
    [parameters setObject:access_token forKey:@"access_token"];
    
    [self requestWithParameter:parameters method:@"users/show.json" successed:^(NSDictionary *resultDic) {
        successed(resultDic);
    } failed:^(NSDictionary *errorDic) {
        failed(errorDic);
    }];
}

@end
