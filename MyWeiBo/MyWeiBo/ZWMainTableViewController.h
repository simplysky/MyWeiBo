//
//  ZWMainTableViewController.h
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWStatusCell.h"

@interface ZWMainTableViewController : UITableViewController<ZWStatusCellDelegate>

@property(nonatomic,strong) NSMutableArray *statuesGroup;

@property(nonatomic,assign) int page;

@end
