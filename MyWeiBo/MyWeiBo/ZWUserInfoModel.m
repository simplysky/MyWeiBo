//
//  ZWUserInfoModel.m
//  MyWeiBo
//
//  Created by simplysky on 16/4/14.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWUserInfoModel.h"

@implementation ZWUserInfoModel


+(instancetype)InitUserInfoWithDic:(NSDictionary *)dic
{
    ZWUserInfoModel *userInfo = [[self alloc] init];
    userInfo.IDStr = [dic objectForKey:@"idstr"];
    userInfo.screenName = [dic objectForKey:@"screen_name"];
    userInfo.name = [dic objectForKey:@"name"];
    userInfo.location = [dic objectForKey:@"location"];
    userInfo.desc = [dic objectForKey:@"description"];
    userInfo.url = [dic objectForKey:@"url"];
    userInfo.profile_image_url = [dic objectForKey:@"profile_image_url"];
    userInfo.domain = [dic objectForKey:@"domain"];
    userInfo.gender = [dic objectForKey:@"gender"];
    userInfo.fllowerCount = [dic objectForKey:@"followers_count"];
    userInfo.stutatsCount = [dic objectForKey:@"statuses_count"];
    userInfo.favouritesCount = [dic objectForKey:@"favourites_count"];
    userInfo.create_at = [dic objectForKey:@"create_at"];
    userInfo.verifed = [dic objectForKey:@"verified"];
    userInfo.follow_me = [dic objectForKey:@"follow_me"];
    userInfo.profile_url = [dic objectForKey:@"profile_url"];
    userInfo.avatar_hd = [dic objectForKey:@"avatar_hd"];
    userInfo.avatar_large = [dic objectForKey:@"avatar_large"];
    return userInfo;
}

@end
