//
//  ZWStatusCell.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWStatusCell.h"
#import <UIKit/UIKit.h>
#import "NSString+Extent.h"
#import "UIImageView+WebCache.h"
#include <math.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


@implementation ZWStatusCell

-(instancetype)initCell:(UITableView *)tableView
{
    static NSString *maincell = @"MainCell";
    ZWStatusCell * cell = nil;//[tableView dequeueReusableCellWithIdentifier:maincell];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZWStatusCell" owner:nil options:nil] firstObject];
    }
    self.userInteractionEnabled = YES;
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
        CGFloat Pwidth = 100;
        CGFloat Pheight = 100;
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
                if(i > 6 && i <= 9)
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
                UIImageView *asyncImage;
                if( count != 1)
                {
                    asyncImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y + height, Pwidth, Pheight)];
                }
                else
                {
                    asyncImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y + height, Pwidth + 60, Pheight+60)];
                }
                //[asyncImage sd_setImageWithURL:[NSURL URLWithString:[key objectForKey:@"thumbnail_pic"]]];
                [asyncImage sd_setImageWithURL:[NSURL URLWithString:[key objectForKey:@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"xiaoduan"]];
                asyncImage.contentMode = UIViewContentModeScaleToFill;
                asyncImage.userInteractionEnabled = YES;
                [self addSubview:asyncImage];
                UITapGestureRecognizer * recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StatusPhotoOnTap:)];
                [asyncImage addGestureRecognizer:recongnizer];
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
        else if(count == 1)
        {
            height += Pheight + 70;
        }
        else if(count > 0)
        {
            height += Pheight + 10;
        }
        
           }
    self.statusesModel.cellLabelHeight = height;
    
    
}

-(void)ShowContent
{
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat padding = 5;
    //UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(padding, height + padding, cellW, 40.0)];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(padding, self.statusesModel.cellLabelHeight + padding, cellW, 40.0)];
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellW, 0.5)];
    splitView.alpha = 0.3;
    splitView.backgroundColor = [UIColor grayColor];
    UIButton *btnRetweet = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cellW/3, 39.5)];
    UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(cellW/3, 0, cellW/3, 39.5)];
    UIButton *btnlike = [[UIButton alloc] initWithFrame:CGRectMake(cellW/3 * 2, 0, cellW/3, 39.5)];
    [btnRetweet setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [btnRetweet setTitle:@"转发" forState:UIControlStateNormal];
    [btnComment setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [btnComment setTitle:@"评论" forState:UIControlStateNormal];
    [btnlike setImage:[UIImage imageNamed:@"timeline_icon_like_disable"] forState:UIControlStateNormal];
    [btnlike setTitle:@"赞" forState:UIControlStateNormal];
    
    [btnRetweet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnRetweet.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnComment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnComment.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnlike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnlike.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [btnRetweet addTarget:self action:@selector(retweetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnComment addTarget:self action:@selector(commentsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnlike addTarget:self action:@selector(likebtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [footerView addSubview:splitView];
    [footerView addSubview:btnRetweet];
    [footerView addSubview:btnComment];
    [footerView addSubview:btnlike];
    [self addSubview:footerView];
    self.statusesModel.cellLabelHeight += 40.0;

}

-(void)retweetBtnClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didRetweetButtonClicked:indexPath:)]) {
        [_delegate didRetweetButtonClicked:sender indexPath:self.indexpath];
    }
}

- (void)commentsBtnClicked:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(didCommentButtonClicked:indexPath:)]){
        [_delegate didCommentButtonClicked:sender indexPath:self.indexpath];
    }
}

-(void)likebtnClicked:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didLikeButtonClicked:indexPath:)]) {
        [_delegate didLikeButtonClicked:sender indexPath:self.indexpath];
    }
}

-(void)StatusPhotoOnTap:(UITapGestureRecognizer *) recongnizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    
    NSDictionary *key;
    int i = 0;
    for (key in self.statusesModel.pic) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:[key objectForKey:@"thumbnail_pic"]];
        //photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
        i++;
    }
    
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recongnizer.view.tag;
    
    // 4.显示浏览器
    [browser show];
}


@end
