//
//  ZWMainTableViewCell.h
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWStatusesModel.h"

@interface ZWMainTableViewCell : UITableViewCell

@property(nonatomic,copy) NSString *ID;

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *content;


@property(nonatomic,weak) ZWStatusesModel *statusesModel;

-(instancetype)initCell:(UITableView *)tableView;

-(void)setCellData:(ZWStatusesModel *) statusesModel;

@end
