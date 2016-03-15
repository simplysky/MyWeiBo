//
//  ZWProfileTableViewControler.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/6.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWProfileTableViewControler.h"

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
        //cell.imageView.image = [UIImage imageNamed:@"xiaoduan.png"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
