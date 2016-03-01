//
//  ZWCommentModel.h
//  MyWeiBo
//  评论
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWUserModel.h"
#import "ZWStatusModel.h"

//created_at 	string 	评论创建时间
//id 	int64 	评论的ID
//text 	string 	评论的内容
//source 	string 	评论的来源
//user 	object 	评论作者的用户信息字段 详细
//mid 	string 	评论的MID
//idstr 	string 	字符串型的评论ID
//status 	object 	评论的微博信息字段 详细
//reply_comment 	object 	评论来源评论，当本评论属于对另一评论的回复时返回此字段

@interface ZWCommentModel : NSObject

@property(nonatomic,copy)   NSString        *created_at;     //评论创建时间
@property(nonatomic,assign) int             *ID;             //评论的ID
@property(nonatomic,copy)   NSString        *text;           //评论的内容
@property(nonatomic,copy)   NSString        *source;         //评论的来源
@property(nonatomic,copy)   ZWUserModel     *user;           //评论作者的用户信息字段 详细
@property(nonatomic,copy)   NSString        *idstr;          //字符串型的评论ID
@property(nonatomic,copy)   ZWStatusModel   *status;         //评论的微博信息字段 详细
@property(nonatomic,copy)   ZWCommentModel  *reply_comment;  //评论来源评论，当本评论属于对另一评论的回复时返回此字段

@end
