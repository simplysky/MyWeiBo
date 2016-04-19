//
//  ZWUserInfoModel.h
//  MyWeiBo
//
//  Created by simplysky on 16/4/14.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWStatusesModel.h"

@interface ZWUserInfoModel : NSObject

//用户UID
@property(nonatomic,copy) NSString *IDStr;
//用户昵称
@property(nonatomic,copy) NSString *screenName;
//友好显示名称
@property(nonatomic,copy) NSString *name;
//所在地
@property(nonatomic,copy) NSString *location;
//描述
@property(nonatomic,copy) NSString *desc;
//个人博客地址
@property(nonatomic,copy) NSString *url;
//用户头像地址（中图）
@property(nonatomic,copy) NSString *profile_image_url;
//用户的微博统一URL地址
@property(nonatomic,copy) NSString *profile_url;
//个性化域名
@property(nonatomic,copy) NSString *domain;
//性别 m：男 f：女  n：未知
@property(nonatomic,copy) NSString *gender;
//粉丝数
@property(nonatomic,copy) NSString *fllowerCount;
//微博数
@property(nonatomic,copy) NSString *stutatsCount;
//收藏数
@property(nonatomic,copy) NSString *favouritesCount;
//用户注册时间
@property(nonatomic,copy) NSString *create_at;
//是否为认证用户
@property(nonatomic,copy) NSString *verifed;
//用户头像地址（大图）
@property(nonatomic,copy) NSString *avatar_large;
//用户头像地址（高清）
@property(nonatomic,copy) NSString *avatar_hd;
//用户的互粉数
@property(nonatomic,copy) NSString *bi_flolowers_count;
//是否已关注我
@property(nonatomic,copy) NSString *follow_me;
//用户的最新一条微博信息
@property(nonatomic,strong) ZWStatusesModel *status;

+(instancetype)InitUserInfoWithDic:(NSDictionary *)dic;

@end
