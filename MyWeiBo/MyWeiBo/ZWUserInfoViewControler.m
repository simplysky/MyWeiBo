//
//  ZWUserInfoViewControler.m
//  MyWeiBo
//
//  Created by simplysky on 16/4/12.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWUserInfoViewControler.h"
#import "SVProgressHUD.h"
#import "ServerRequestManager.h"

@interface ZWUserInfoViewControler()

@property(nonatomic,strong) UIScrollView *mainscrollView;

@property(nonatomic,strong) UITableView *leftTableView;
@property(nonatomic,strong) UITableView *rightTableView;
@property(nonatomic,strong) UIScrollView *tableSCrollView;


@end

@implementation ZWUserInfoViewControler

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initScrollView];
    [self initUserHeader];
    [self initTableView];
    self.navigationController.navigationBar.alpha= 0;
}

#pragma -mark 数据获取
-(void)getUserInfo
{
    [SVProgressHUD showInfoWithStatus:@"正在加载...."];
    
    [[ServerRequestManager shared] getUserInfoWithUid:@"2031201467" name:nil RequestWithSuccessed:^(NSDictionary *dic) {
        if([dic allKeys] == 0)
        {
            return;
        }
        self.userInfo = [ZWUserInfoModel InitUserInfoWithDic:dic];
        
    } failed:^(NSDictionary *errorDic) {
        NSString *tip = [errorDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:tip];
    }];
}

-(void)initScrollView
{
    if(self.mainscrollView == nil)
    {
        self.mainscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        self.mainscrollView.delegate = self;
        self.mainscrollView.scrollEnabled = YES;
        self.mainscrollView.showsVerticalScrollIndicator = YES;
        self.mainscrollView.contentSize = CGSizeMake(0, [[UIScreen mainScreen] bounds].size.height);
        self.mainscrollView.userInteractionEnabled = YES;
        [self.view addSubview:self.mainscrollView];
    }
}

-(void)initUserHeader
{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 160)];
    header.image = [UIImage imageNamed:@"page_cover_car_background"];
    header.contentMode = UIViewContentModeScaleToFill;
    header.userInteractionEnabled = YES;
    UIImageView *usericon = [[UIImageView alloc] initWithFrame:CGRectMake(header.center.x - 30, 20, 60, 60)];
    usericon.image = [UIImage imageNamed:@"xiaoduan"];
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(header.center.x - 0.5, 85, 1, 20)];
    UIButton *btnCare = [[UIButton alloc] initWithFrame:CGRectMake(header.center.x - 100,85, 100, 20)];
    UIButton *btnFans = [[UIButton alloc] initWithFrame:CGRectMake(header.center.x + 0.5,85, 100, 20)];
    [btnCare setTitle:@"关注" forState:UIControlStateNormal];
    btnCare.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnFans setTitle:@"粉丝" forState:UIControlStateNormal];
    btnFans.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    spaceView.backgroundColor = [UIColor greenColor];
    [btnCare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFans setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *lblDetail = [[UILabel alloc] initWithFrame:CGRectMake(header.center.x - 100, 110, 200, 20)];
    [lblDetail setText:@"gerenjianjie"];
    [lblDetail setTextColor:[UIColor blackColor]];
    [lblDetail setTextAlignment:NSTextAlignmentCenter];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 160 - 28, header.frame.size.width, 28)];
    btnView.userInteractionEnabled = YES;
    UIButton *btnMy = [[UIButton alloc] initWithFrame:CGRectMake(header.frame.size.width/2 - 40, 1, 45, 27)];
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake(header.frame.size.width/2 + 5, 1, 45, 27)];
    [btnMy setTitle:@"主页" forState:UIControlStateNormal];
    [btnStatus setTitle:@"微博" forState:UIControlStateNormal];
    [btnMy addTarget:self action:@selector(changeTableViewClick) forControlEvents:UIControlEventTouchUpInside];
    [btnStatus addTarget:self action:@selector(changeTableViewClick) forControlEvents:UIControlEventTouchUpInside];
    [btnMy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnStatus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnView addSubview:btnMy];
    [btnView addSubview:btnStatus];
    btnView.backgroundColor = [UIColor whiteColor];
    
    [header addSubview:usericon];
    [header addSubview:spaceView];
    [header addSubview:btnCare];
    [header addSubview:btnFans];
    [header addSubview:lblDetail];
    [header addSubview:btnView];
    
    [self.mainscrollView addSubview:header];
    
}

-(void)changeTableViewClick
{
    if (self.tableSCrollView.contentOffset.x < [[UIScreen mainScreen] bounds].size.width) {
        [self.tableSCrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width, 0) animated:NO];
    }
    else
    {
        [self.tableSCrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

-(void)initTableView
{
    if(self.tableSCrollView == nil)
    {
        self.tableSCrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, 300)];
        self.tableSCrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, 300);
        self.tableSCrollView.scrollEnabled = NO;
        self.tableSCrollView.userInteractionEnabled = YES;
        if(self.leftTableView == nil)
        {
            self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 300)];
            self.leftTableView.delegate = self;
            self.leftTableView.dataSource = self;
            [self.tableSCrollView addSubview:self.leftTableView];
        }
        if(self.rightTableView == nil)
        {
            self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, 300)];
            self.rightTableView.backgroundColor = [UIColor blackColor];
            self.rightTableView.delegate = self;
            self.rightTableView.dataSource = self;
            [self.tableSCrollView addSubview:self.rightTableView];
        }
        
        [self.mainscrollView addSubview:self.tableSCrollView];
    }
}

#pragma -TableView事件

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:self.leftTableView])
    {
        if (section == 0) {
            return 2;
        }
    }
    else if([tableView isEqual:self.rightTableView])
    {
        return 0;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:self.leftTableView])
    {
        return 1;
    }
    else if([tableView isEqual:self.rightTableView])
    {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:self.leftTableView])
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        cell.detailTextLabel.text = @"nihao";
        cell.textLabel.text = @"wohao";
        return cell;
    }
    else if([tableView isEqual:self.rightTableView])
    {
        return nil;
    }
    
    return nil;

}

#pragma -ScrollView事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat x = scrollView.contentOffset.y;
//    if(x <= 80)
//    {
//        self.navigationController.navigationBar.alpha= x;
//    }
    
}

@end
