//
//  ZWMainTableViewController.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWMainTableViewController.h"
#import "ZWStatusCell.h"
#import "AFHTTPRequestOperation.h"
#import "CommonInfo.h"
#import "ZWDetailTableViewControler.h"
#import "MJRefresh.h"
#import "ZWStatusesModel.h"

@interface ZWMainTableViewController ()

@end

@implementation ZWMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statuesGroup = [NSMutableArray new];
    self.page =1;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadNewData];
            
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    [self loadMoreData];
}


#pragma mark -上拉刷新 与 下拉加载
-(void)loadNewData
{
    NSString *firstID = [self.statuesGroup firstObject];
    NSString *str=[NSString stringWithFormat:@"%@statuses/friends_timeline.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=100&page=%d&since_id=%@&feature=1",BASE_URL,self.page,firstID];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        NSDictionary *key;
        for (key in [dict objectForKey:@"statuses"]) {
            ZWStatusesModel *statusesMode = [ZWStatusesModel new];
            statusesMode.ID = [key objectForKey:@"id"];
            statusesMode.Content = [key objectForKey:@"text"];
            statusesMode.userName = [[key objectForKey:@"user"] objectForKey:@"screen_name"];
            statusesMode.location = [[key objectForKey:@"user"] objectForKey:@"location"];
            
            NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
            UIImage *image=[[UIImage alloc] initWithData:imageData];
            statusesMode.userIcon = image;
            
            statusesMode.pic =[key objectForKey:@"pic_urls"];
            [self.statuesGroup insertObject:statusesMode atIndex:0];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}

-(void)loadMoreData
{
    NSString *str=[NSString stringWithFormat:@"%@statuses/friends_timeline.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=10&page=%d&feature=1",BASE_URL,self.page];
    //NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        NSDictionary *key;
        for (key in [dict objectForKey:@"statuses"]) {
            ZWStatusesModel *statusesMode = [ZWStatusesModel new];
            statusesMode.ID = [key objectForKey:@"id"];
            statusesMode.Content = [key objectForKey:@"text"];
            statusesMode.userName = [[key objectForKey:@"user"] objectForKey:@"screen_name"];
            statusesMode.location = [[key objectForKey:@"user"] objectForKey:@"location"];
            
            NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
            UIImage *image=[[UIImage alloc] initWithData:imageData];
            statusesMode.userIcon = image;
            statusesMode.pic =[key objectForKey:@"pic_urls"];
            
            [self.statuesGroup addObject:statusesMode];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }
        if([[dict objectForKey:@"statuses"] count] > 0)
        {
            self.page++;
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.statuesGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWStatusCell * cell = [[ZWStatusCell alloc] initCell:tableView];
    [cell setCellData:self.statuesGroup[indexPath.section]];
    [cell ShowContent];
    cell.delegate = self;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWStatusesModel *model = self.statuesGroup[indexPath.section];
    return model.cellLabelHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ZWDetailTableViewControler *detail = [[ZWDetailTableViewControler alloc] init];
    ZWStatusesModel *model = self.statuesGroup[indexPath.section];
    detail.statuses = model;
    [detail setTitle:@"微博正文"];
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -自定义Cell中的Delegate

//转发
-(void)didRetweetButtonClicked:(UIButton *)btnRetweet indexPath:(NSIndexPath *)indexpath
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                   message:@"message"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OtherBtn",@"nextBtn",nil];
    [view show];
    
}

//评论
-(void)didCommentButtonClicked:(UIButton *)btnComment indexPath:(NSIndexPath *)indexpath
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                   message:@"message"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OtherBtn",nil];
    [view show];
}

//点赞
-(void)didLikeButtonClicked:(UIButton *)btnLike indexPath:(NSIndexPath *)indexpath
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                   message:@"message"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OtherBtn",nil];
    [view show];
}



@end
