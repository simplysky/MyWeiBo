//
//  ZWCommentsTableViewCell.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/3.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWCommentsTableViewCell.h"

@implementation ZWCommentsTableViewCell

-(instancetype)initCell:(UITableView *)tableView
{
    static NSString *commentcell =  @"CommentCell";
    ZWCommentsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentcell];
    if( cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentsTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

-(void)setCellData:(ZWCommentsModel *)comments
{
    self.lblComment.text = comments.text;
    self.header.image = comments.usericon;
    [self.btnName setTitle:comments.username forState:UIControlStateNormal];
    self.lblDesc.text = comments.location;
}

@end
