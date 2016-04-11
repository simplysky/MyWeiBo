//
//  ZWMainTabBarControler.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/1.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "ZWMainTabBarControler.h"
#import "TabBarButton.h"

@interface ZWMainTabBarControler()
{
    TabBarButton *lastButton;
    NSMutableArray *_tabbarBtnArr;
}

@end

#define NormalColor [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1]
#define SelectColor [UIColor colorWithRed:214.0/255.0 green:28.0/255.0 blue:34.0/255.0 alpha:1.0]
#define TabBarColor [UIColor colorWithRed:241/266.0 green:245/255.0 blue:246/255.0 alpha:1]
#define TabBarShadow [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0]

@implementation ZWMainTabBarControler

-(void)viewDidLoad{
    
}


- (void)clickTabBarButton:(TabBarButton *)btn
{
    [lastButton setSelected:NO];
    [lastButton.title setTextColor:NormalColor];
    lastButton = btn;
    [lastButton setSelected:YES];
    [lastButton.title setTextColor:SelectColor];
    self.selectedIndex = lastButton.tag;
}

-(void)changeTabbarBtnWithNum:(NSNumber *)num{
    TabBarButton *btn = [_tabbarBtnArr objectAtIndex:[num integerValue]];
    [self clickTabBarButton:btn];
}

@end
