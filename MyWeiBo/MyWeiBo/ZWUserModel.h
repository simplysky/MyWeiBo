//
//  ZWUserModel.h
//  MyWeiBo
//  微博用户模型
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWStatusModel.h"

@interface ZWUserModel : NSObject

@property(nonatomic,assign)     int             *ID;                //用户ID
@property(nonatomic,copy)       NSString        *idstr;             //字符串类型的用户ID
@property(nonatomic,copy)       NSString        *screen_name;       //用户昵称
@property(nonatomic,copy)       NSString        *name;              //友好显示名称
@property(nonatomic,assign)     int             *province;          //用户省级ID
@property(nonatomic,assign)     int             *city;              //用户市级所在ID
@property(nonatomic,copy)       NSString        *location;          //用户所在地
@property(nonatomic,copy)       NSString        *desc;              //用户描述
@property(nonatomic,copy)       NSString        *url;               //用户博客地址
@property(nonatomic,copy)       NSString        *profile_image_url; //用户头像地址（中图），50×50像素
@property(nonatomic,copy)       NSString        *profile_url;       //用户的微博统一URL地址
@property(nonatomic,copy)       NSString        *domain;            //用户的个性化域名
@property(nonatomic,copy)       NSString        *weihao;            //用户的微号
@property(nonatomic,copy)       NSString        *gender;            //性别，m：男、f：女、n：未知
@property(nonatomic,assign)     int             *followers_count;   //粉丝数
@property(nonatomic,assign)     int             *friends_count;     //关注数
@property(nonatomic,assign)     int             *statuses_count;    //微博数
@property(nonatomic,assign)     int             *favourites_count;  //收藏数
@property(nonatomic,copy)       NSString        *created_at;        //用户创建（注册）时间
@property(nonatomic,assign)     BOOL            *following;         //暂未支持
@property(nonatomic,assign)     BOOL            *allow_all_act_msg; //是否允许所有人给我发私信，true：是，false：否
@property(nonatomic,assign)     BOOL            *geo_enabled;       //是否允许标识用户的地理位置，true：是，false：否
@property(nonatomic,assign)     BOOL            *verified;          //是否是微博认证用户，即加V用户，true：是，false：否
@property(nonatomic,assign)     int             *verified_type;     //暂未支持
@property(nonatomic,copy)       NSString        *remark;            //用户备注信息，只有在查询用户关系时才返回此字段
//@property(nonatomic,copy)       ZWStatusModel   *status;            //用户的最近一条微博信息字段 详细
@property(nonatomic,assign)     BOOL            *allow_all_comment; //是否允许所有人对我的微博进行评论，true：是，false：否
@property(nonatomic,copy)       NSString        *avatar_large;      //用户头像地址（大图），180×180像素
@property(nonatomic,copy)       NSString        *avatar_hd;         //用户头像地址（高清），高清头像原图
@property(nonatomic,copy)       NSString        *verified_reason;   //认证原因
@property(nonatomic,copy)       NSString        *follow_me;         //该用户是否关注当前登录用户，true：是，false：否
@property(nonatomic,assign)     int             *online_status;     //用户的在线状态，0：不在线、1：在线
@property(nonatomic,assign)     int             *bi_followers_count;//用户的互粉数
@property(nonatomic,copy)       NSString        *lang;              //用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语

@end
