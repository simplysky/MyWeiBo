//
//  ZWDetailTableViewControler.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/3.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWDetailTableViewControler.h"
#import "AFHTTPRequestOperation.h"
#import "CommonInfo.h"
#import "ZWCommentsTableViewCell.h"
#import "ZWMainTableViewCell.h"
#import "MJRefresh.h"

@implementation ZWDetailTableViewControler

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    if(self.commentsGroup == nil)
    {
        self.commentsGroup = [NSMutableArray new];
    }
    self.page = 1 ;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    
    [self loadMoreData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    return self.commentsGroup.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZWMainTableViewCell * cell = [[ZWMainTableViewCell alloc] initCell:tableView];
        [cell setCellData:self.statuses];
        return cell;
    }
    else
    {
        ZWCommentsTableViewCell * cell = [[ZWCommentsTableViewCell alloc]initCell:tableView];
        
        [cell setCellData:self.commentsGroup[indexPath.row]];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.statuses.cellLabelHeight;
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)loadMoreData
{
    NSString *str=[NSString stringWithFormat:@"%@comments/show.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=30&page=%d&id=%@",BASE_URL,self.page,self.statuses.ID];
    
    NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        NSDictionary *key;
        for (key in [dict objectForKey:@"comments"]) {
            ZWCommentsModel *comments = [ZWCommentsModel new];
            comments.ID = [key objectForKey:@"id"];
            comments.text = [key objectForKey:@"text"];
            comments.creat_at = [key objectForKey:@"creat_at"];
            comments.source = [key objectForKey:@"source"];
            comments.location = [[key objectForKey:@"user"] objectForKey:@"location"];
            comments.username = [[key objectForKey:@"user"] objectForKey:@"screen_name"];
            NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
            UIImage *image = [UIImage imageWithData:imageData];
            comments.usericon = image;
            [self.commentsGroup addObject:comments];
        }
        if([[dict objectForKey:@"comments"] count] > 0)
        {
            self.page++;
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}

@end
