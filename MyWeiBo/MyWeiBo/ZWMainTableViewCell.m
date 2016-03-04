//
//  ZWMainTableViewCell.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWMainTableViewCell.h"


@implementation ZWMainTableViewCell

-(instancetype)initCell:(UITableView *)tableView
{
    static NSString *maincell = @"MainCell";
    ZWMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:maincell];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZWMainTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

-(void)setCellData:(ZWStatusesModel *)statusesModel
{
    self.statusesModel = statusesModel;
    self.ID = self.statusesModel.ID;
    self.content.text = self.statusesModel.Content;
    self.name.text = self.statusesModel.userName;
    self.desc.text = self.statusesModel.location;
    [self.header setImage:self.statusesModel.userIcon];
}


@end
