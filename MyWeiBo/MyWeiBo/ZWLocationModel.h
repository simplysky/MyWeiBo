//
//  ZWLocationModel.h
//  MyWeiBo
//  地理信息
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWLocationModel : NSObject


@property(nonatomic,copy) NSString *ongitude;       //经度坐标
@property(nonatomic,copy) NSString *latitude;       //维度坐标
@property(nonatomic,copy) NSString *city;           //所在城市的城市代码
@property(nonatomic,copy) NSString *province;       //所在省份的省份代码
@property(nonatomic,copy) NSString *city_name;      //所在城市的城市名称
@property(nonatomic,copy) NSString *province_name;  //所在省份的省份名称
@property(nonatomic,copy) NSString *address;        //所在的实际地址，可以为空
@property(nonatomic,copy) NSString *pinyin;         //地址的汉语拼音，不是所有情况都会返回该字段
@property(nonatomic,copy) NSString *more;           //更多信息，不是所有情况都会返回该字段

@end
