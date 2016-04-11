//
//  ZWCommentsCell.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/3.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWCommentsModel.h"

@interface ZWCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header;

@property (weak, nonatomic) IBOutlet UIButton *btnName;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

-(instancetype)initCell:(UITableView *)tableView;

-(void)setCellData:(ZWCommentsModel *)comments;

@end
