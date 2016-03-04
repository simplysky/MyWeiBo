//
//  ZWDetailTableViewControler.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/3.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWDetailTableViewControler : UITableViewController

@property(nonatomic,copy) NSString *weiboID;

@property(nonatomic,copy) NSString *weiboText;
@property(nonatomic,copy) NSString *weiboDesc;
@property(nonatomic,copy) UIImage *userHeaer;
@property(nonatomic,copy) NSString *weiboLocation;
@property(nonatomic,copy) NSString *username;

@property(nonatomic,copy) NSMutableDictionary *comments;

@property(nonatomic,assign) int page;

@end
