//
//  ZWStatusesModel.h
//  MyWeiBo
//  微博模型
//  Created by simplysky on 16/3/4.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZWStatusesModel : NSObject

//用户编号
@property(nonatomic,copy) NSString  *ID;
//用户昵称
@property(nonatomic,copy) NSString  *userName;
//用户位置
@property(nonatomic,copy) NSString  *location;
//用户头像
@property(nonatomic,copy) UIImage   *userIcon;
//内容
@property(nonatomic,copy) NSString  *Content;
//转发数
@property(nonatomic,copy) NSString  *reposts_count;
//评论数
@property(nonatomic,copy) NSString  *comments_count;
//表态数
@property(nonatomic,copy) NSString  *attitudes_count;
//微博配图
@property(nonatomic,strong) NSDictionary   *pic;

//根据内容计算所需高度
@property (nonatomic,assign) CGFloat cellLabelHeight;




@end
