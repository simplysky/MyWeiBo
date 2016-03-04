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

@implementation ZWDetailTableViewControler

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1 ;
    //self.weiboID = @"3948936492485702";
    [self LoadData];
    
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
    return [[self.comments objectForKey:@"comments"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *maincell =  @"MainCell";
        ZWMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:maincell];
        if(cell == nil){
            //cell = [[ZWMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:maincell];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZWMainTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.content.text = self.weiboText;
        cell.name.text = self.username;
        cell.desc.text = self.weiboDesc;
        [cell.header setImage:self.userHeaer];
        return cell;
    }
    else
    {
        static NSString *commentcell =  @"CommentCell";
        ZWCommentsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentcell];
        if( cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentsTableViewCell" owner:nil options:nil] firstObject];
        }
        
        NSDictionary *key = [[self.comments objectForKey:@"comments"] objectAtIndex:indexPath.row];
        
        cell.lblComment.text = [key objectForKey:@"text"];
        NSDictionary *user = [key objectForKey:@"user"];
        NSString *URL = [[key objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
        cell.header.image = [[UIImage alloc] initWithData:data];
        [cell.btnName setTitle:[user objectForKey:@"screen_name"] forState:UIControlStateNormal];
        cell.lblDesc.text = [user objectForKey:@"location"];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)LoadData
{
    NSString *str=[NSString stringWithFormat:@"%@comments/show.json?access_token=2.008WiTjC0tfnxh39f60ed4e70Vfgeo&count=30&page=%d&id=%@",BASE_URL,self.page,self.weiboID];
    self.page++;
    
    NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        if(self.comments == nil)
        {
            self.comments = dict;
        }
        else
        {
            [self.comments addEntriesFromDictionary:dict];
        }
        [self.tableView reloadData];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}

@end
