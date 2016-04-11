//
//  ZWStatusCell.h
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWStatusesModel.h"

@protocol ZWStatusCellDelegate <NSObject>

-(void)didRetweetButtonClicked:(UIButton *) btnRetweet indexPath:(NSIndexPath *) indexpath;
-(void)didCommentButtonClicked:(UIButton *) btnComment indexPath:(NSIndexPath *) indexpath;
-(void)didLikeButtonClicked:(UIButton *) btnLike indexPath:(NSIndexPath *) indexpath;

@end

@interface ZWStatusCell : UITableViewCell

@property(nonatomic,copy) NSString *ID;

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property(nonatomic,strong) id<ZWStatusCellDelegate>delegate;
@property (nonatomic , strong) NSIndexPath *indexpath;

@property(nonatomic,weak) ZWStatusesModel *statusesModel;

-(instancetype)initCell:(UITableView *)tableView;

-(void)setCellData:(ZWStatusesModel *) statusesModel;





//显示footer
-(void)ShowContent;

@end
