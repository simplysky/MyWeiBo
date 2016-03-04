//
//  ZWCommentsModel.h
//  MyWeiBo
//  微博评论
//  Created by simplysky on 16/3/4.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWCommentsModel : NSObject

@property(nonatomic,copy) NSString  *creat_at;

@property(nonatomic,copy) NSString *ID;

@property(nonatomic,copy) NSString *source;

@property(nonatomic,copy) NSString *username;

@property(nonatomic,copy) UIImage *usericon;

@property(nonatomic,copy) NSString *location;

@property(nonatomic,copy) NSString *text;

@end
