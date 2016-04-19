//
//  ZWProfileTableViewControler.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/6.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWProfileTableViewControler.h"
#import "ZWUserInfoViewControler.h"


@interface ZWProfileTableViewControler ()

@end

@implementation ZWProfileTableViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *normalCell = @"normalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalCell];
    }
    if(indexPath.section == 0)
    {
        UIImage *icon = [UIImage imageNamed:@"xiaoduan.png"];
        CGSize itemSize = CGSizeMake(60, 60);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.textLabel.text = @"simplysky";
        cell.detailTextLabel.text = @"我的简介";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"我的微博";
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"我的粉丝";
        }
        else
        {
            cell.textLabel.text = @"我的关注";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        ZWUserInfoViewControler *userInfo = [[ZWUserInfoViewControler alloc] init];
        [self.navigationController pushViewController:userInfo animated:YES];
    }
    else
    {
        if (indexPath.row == 0) { //我的微博
            
        }
        else if(indexPath.row == 1){//我的粉丝
        
        }
        else if(indexPath.row == 2){//我的关注
        
        }
    }
}


@end
