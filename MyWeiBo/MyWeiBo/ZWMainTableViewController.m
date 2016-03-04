//
//  ZWMainTableViewController.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWMainTableViewController.h"
#import "ZWMainTableViewCell.h"
#import "AFHTTPRequestOperation.h"
#import "CommonInfo.h"
#import "ZWDetailTableViewControler.h"
#import "MJRefresh.h"

@interface ZWMainTableViewController ()

@end

@implementation ZWMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}


#pragma mark -上拉刷新 与 下拉加载
-(void)loadNewData
{
    
}

-(void)loadMoreData
{
    NSString *str=[NSString stringWithFormat:@"%@statuses/friends_timeline.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=30&page=%d",BASE_URL,self.page];
    self.page++;
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        if(self.dic == nil)
        {
            self.dic = dict;
        }
        else
        {
            [self.dic addEntriesFromDictionary:dict];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        
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
    return [[self.dic objectForKey:@"statuses"] count] ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *maincell = @"MainCell";
    ZWMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:maincell];
    if(cell == nil){
    //cell = [[ZWMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:maincell];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZWMainTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.header.image = [UIImage imageNamed:@"xiaoduan.png"];
    NSDictionary *key = [[self.dic objectForKey:@"statuses"] objectAtIndex:indexPath.section];
    cell.content.text = [key objectForKey:@"text"];
    cell.name.text = [[key objectForKey:@"user"] objectForKey:@"screen_name"];
    cell.desc.text = [[key objectForKey:@"user"] objectForKey:@"location"];

    NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    [cell.header setImage:image];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section:(NSInteger)section
{
    return 5;
}
-(void)loaData
{
//    NSString *str=[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
//    
//    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    //    从URL获取json数据
//    
//    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:requestsuccess:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
//        
//        NSLog(@"获取到的数据为：%@",JSON);
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
//        
//        NSLog(@"发生错误！%@",error);
//        
//    }];
//    
//    [operation1 start];
    NSString *str=[NSString stringWithFormat:@"%@statuses/friends_timeline.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=30&page=%d",BASE_URL,self.page];
    self.page++;
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        if(self.dic == nil)
        {
            self.dic = dict;
        }
        else
        {
            [self.dic addEntriesFromDictionary:dict];
        }
        [self.tableView reloadData];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [[self.dic objectForKey:@"statuses"] count]) {
        //”加载更多“单元格事件
        [self performSelectorInBackground:@selector(loaData) withObject:nil];
        //[loadMoreCell setHighlighted:NO];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    else
    {
        ZWDetailTableViewControler *detail = [[ZWDetailTableViewControler alloc] init];
        NSInteger x = indexPath.section;
        NSDictionary *key = [[self.dic objectForKey:@"statuses"] objectAtIndex:x];
        detail.weiboID = [key objectForKey:@"id"];
        detail.weiboText = [key objectForKey:@"text"];
        detail.username = [[key objectForKey:@"user"] objectForKey:@"screen_name"];
        detail.weiboDesc= [[key objectForKey:@"user"] objectForKey:@"location"];
        
        NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        detail.userHeaer = image;
        [detail setTitle:@"微博正文"];
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}



@end
