//
//  OAuthWebViewController.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAuthWebViewController :UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
