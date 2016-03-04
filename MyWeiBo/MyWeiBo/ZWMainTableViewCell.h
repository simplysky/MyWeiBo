//
//  ZWMainTableViewCell.h
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (weak, nonatomic) IBOutlet UILabel *content;

@end
