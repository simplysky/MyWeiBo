//
//  ZWUserInfoViewControler.h
//  MyWeiBo
//
//  Created by simplysky on 16/4/12.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWUserInfoModel.h"

@interface ZWUserInfoViewControler :UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) ZWUserInfoModel *userInfo;

@end
