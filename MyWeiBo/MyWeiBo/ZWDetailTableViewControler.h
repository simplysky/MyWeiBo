//
//  ZWDetailTableViewControler.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/3.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWStatusesModel.h"

@interface ZWDetailTableViewControler : UITableViewController

@property(nonatomic,strong) ZWStatusesModel *statuses;

@property(nonatomic,strong) NSMutableArray *commentsGroup;

@property(nonatomic,assign) int page;

@end
