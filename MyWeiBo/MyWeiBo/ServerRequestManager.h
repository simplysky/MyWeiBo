//
//  ServerRequestManager.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/21.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^RequestResult) (NSDictionary *obj);

@interface ServerRequestManager : NSObject

+(instancetype)shared;

#pragma mark -json字符与object的互转
+(id)JsonStringToData:(NSString *)jsonString;
+(NSString *)dataToJsonString:(id)object;

/** 获取用户信息 **/
-(void)getUserInfoWithUid:(NSString *)uid name:(NSString *)screenName RequestWithSuccessed:(void(^)(NSDictionary *dic))successed failed:(void(^)(NSDictionary *errorDic))failed;

@end
