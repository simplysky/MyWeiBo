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
    [super viewDidLoad];
    [self addNewTabBar];
}

//添加tabbar
-(void)addNewTabBar
{
    CGSize viewsize = [[UIScreen mainScreen] bounds].size;
    UIView *tabbarBackgroud = [[UIView alloc] init];
    [tabbarBackgroud setFrame:CGRectMake(0, viewsize.height-49, viewsize.width, 49)];
    [tabbarBackgroud setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:tabbarBackgroud];
    
    UIImageView *shadowLine = [[UIImageView alloc] init];
    [shadowLine setFrame:CGRectMake(0, -1, viewsize.width, 0.5)];
    [shadowLine setBackgroundColor:TabBarShadow];
    [tabbarBackgroud addSubview:shadowLine];
    NSArray *titleArray = @[@"首页",@"消息",@"发现",@"我"];
    NSArray *titleImageNor = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    NSArray *titleImageSel = @[@"tabbar_home_selected",@"tabbar_message_center_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
    CGFloat titleWidth = viewsize.width/titleArray.count;
    
    for (int i = 0; i<titleArray.count; i++) {
        TabBarButton *titleButton = [[TabBarButton alloc] init];
        [titleButton setFrame:CGRectMake(0, 0, 22, 22)];
        [titleButton setCenter:CGPointMake(titleWidth/2+i*titleWidth, 18)];
        [titleButton setImage:[UIImage imageNamed:[titleImageNor objectAtIndex:i]] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:[titleImageSel objectAtIndex:i]] forState:UIControlStateSelected];
        [titleButton setBackgroundColor:[UIColor clearColor]];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(clickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.title = [[UILabel alloc] init];
        [titleButton.title setFont:[UIFont systemFontOfSize:10]];
        [titleButton.title setFrame:CGRectMake(0, 0, 50, 21)];
        [titleButton.title setCenter:CGPointMake(titleButton.center.x + 2, titleButton.center.y + 22)];
        
        [titleButton.title setText:[titleArray objectAtIndex:i]];
        [titleButton.title setTextAlignment:NSTextAlignmentCenter];
        [titleButton.title setTextColor:NormalColor];
        
        if(i == 0 )
        {
            [titleButton.title setTextColor:SelectColor];
            lastButton = titleButton;
            [lastButton setSelected:YES];
        }
        
        if(_tabbarBtnArr == nil)
        {
            _tabbarBtnArr = [[NSMutableArray alloc] init];
        }
        [_tabbarBtnArr addObject:titleButton];
        [tabbarBackgroud addSubview:titleButton];
        [tabbarBackgroud addSubview:titleButton.title];
    }
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
