//
//  ZWMainTableViewCell.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWMainTableViewCell.h"
#import <UIKit/UIKit.h>
#import "NSString+Extent.h"
#import "UIImageView+WebCache.h"
#import "ZWStatusCollectionViewController.h"
#include <math.h>


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
    CGFloat height = 0.0;
    //设置高度
    //1、获取屏幕的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //2、设置detailDescriptionLabel的宽度
    CGFloat marginW = 8;
    CGFloat photoW = 50;
    CGFloat descLabelW = cellW - photoW - 3*marginW;
    CGFloat detailLabelHeight = [self.statusesModel.Content heightWithText:self.statusesModel.Content font:[UIFont systemFontOfSize:14.0] width:descLabelW];
    height = 35 + detailLabelHeight + 10; //上面内容个的高度
    //height = 35 + 50 + 10; //上面内容个的高度
    
    if(statusesModel.pic != nil)
    {
        CGFloat Pwidth = 120;
        CGFloat Pheight = 120;
        CGFloat padding = 5;
        
        NSInteger count = statusesModel.pic.count;
        
        
        if(count > 0)
        {
            NSDictionary *key;
            int i =1;
            for ( key in statusesModel.pic) {
                //确定图片X Y的坐标
                int temp = 0;
                CGFloat x = 0;
                CGFloat y = 10;
                if(i > 6)
                {
                    temp = i%7;
                    y = padding * 3 + Pheight * 2;
                }
                else if(i > 3)
                {
                    temp = i % 4;
                    y = padding * 2 + Pheight;
                }
                else
                {
                    temp = (i+3) % 4;
                    y = padding;
                }
                x = (temp + 1) * padding + temp * Pwidth;
                UIImageView *asyncImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y + height, Pwidth, Pheight)];
                [asyncImage setImageWithURL:[NSURL URLWithString:[key objectForKey:@"thumbnail_pic"]]];
                [self addSubview:asyncImage];
                i++;
            }
        }
        
        if(count > 6)
        {
            height += Pheight*3 + 30;
        }
        else if(count > 3)
        {
            height += Pheight*2 + 20;
        }
        else if(count > 0)
        {
            height += Pheight + 10;
        }
    }
    self.statusesModel.cellLabelHeight = height;
    
    
}


@end
