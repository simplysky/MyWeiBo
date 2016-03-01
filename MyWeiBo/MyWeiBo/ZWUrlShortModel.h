//
//  ZWUrlShort.h
//  MyWeiBo
//  短链
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWUrlShortModel : NSObject

@property(nonatomic,copy)   NSString    *url_short; 	//短链接
@property(nonatomic,copy)   NSString    *url_long;      //原始长链接
@property(nonatomic,assign) int         *type;          //链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
@property(nonatomic,assign) int         *result;        //短链的可用状态，true：可用、false：不可用。

@end
