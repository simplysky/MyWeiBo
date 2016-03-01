//
//  OAuthWebViewController.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "OAuthWebViewController.h"

@implementation OAuthWebViewController
@synthesize webView;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *url = @"https://api.weibo.com/oauth2/authorize?client_id=649634753&redirect_uri=https://api.weibo.com/oauth2/default.html&response_type=code&display=mobile";
    //NSString *url = @"http://m.baidu.com";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webView setDelegate:self];
    [self.webView loadRequest:request];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UIWebView Delegate Methods

-(void)webViewDidFinishLoad:(UIWebView *)_webView
{
    NSString *url = _webView.request.URL.absoluteString;
    NSLog(@"absoluteString:%@",url);
    
    if ([url hasPrefix:@"https://api.weibo.com/oauth2/default.html?"]) {
        
        //找到”code=“的range
        NSRange rangeOne;
        rangeOne=[url rangeOfString:@"code="];
        
        //根据他“code=”的range确定code参数的值的range
        NSRange range = NSMakeRange(rangeOne.length+rangeOne.location, url.length-(rangeOne.length+rangeOne.location));
        //获取code值
        NSString *codeString = [url substringWithRange:range];
        NSLog(@"code = :%@",codeString);
        
        //access token调用URL的string
        NSMutableString *muString = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/oauth2/access_token?client_id=649634753&client_secret=1fcdf9ab4ce2a2882bb4c2d894b848c0&grant_type=authorization_code&redirect_uri=https://api.weibo.com/oauth2/default.html&code="];
        [muString appendString:codeString];
        NSLog(@"access token url :%@",muString);
        
        //第一步，创建URL
        NSURL *urlstring = [NSURL URLWithString:muString];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = @"type=focus-c";//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
        NSLog(@"Back String :%@",str1);
        
        NSError *error;
        //如何从str1中获取到access_token
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:&error];
        
        NSString *_access_token = [dictionary objectForKey:@"access_token"];
        NSLog(@"access token is:%@",_access_token);//2.008WiTjC0tfnxh39f60ed4e70Vfgeo
        
    }
}

@end
