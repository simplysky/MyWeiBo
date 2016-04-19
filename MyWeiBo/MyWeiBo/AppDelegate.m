//
//  AppDelegate.m
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWMainTableViewController.h"
#import "ZWProfileTableViewControler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self gotoHomeViewControl];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

-(void)gotoHomeViewControl{
    if (!self.tabBar) {
        ZWMainTableViewController *vcHome = [[ZWMainTableViewController alloc] init];
        ZWProfileTableViewControler * vcProfile = [[ZWProfileTableViewControler alloc] init];
        UIViewController *vcMessage = [[UIViewController alloc] init];
        UIViewController *vcDiscover = [[UIViewController alloc] init];
        [vcHome setTitle:@"主页"];
        [vcMessage setTitle:@"消息"];
        [vcDiscover setTitle:@"发现"];
        [vcProfile setTitle:@"我"];
        self.tabBar = [[ZWMainTabBarControler alloc] init];
        self.tabBar.view.bounds = [[UIScreen mainScreen] bounds];
        self.tabBar.viewControllers = @[vcHome,vcMessage,vcDiscover,vcProfile];
        self.navi = [[ZWNavigationController alloc] initWithRootViewController:self.tabBar];
        [self.navi setNavigationBarHidden:NO];
    }
    [self.window setRootViewController:self.navi];
}

-(void)gotoTabBarVcWithNumber:(NSNumber *)num{
    if ([num integerValue] == 0) {
        ZWMainTableViewController *vcHome  = [self.tabBar.viewControllers objectAtIndex:[num integerValue]];
        [self.tabBar setSelectedViewController:vcHome];
    }
    else if([num integerValue] == 1){
        ZWProfileTableViewControler *vcProfile = [self.tabBar.viewControllers objectAtIndex:[num integerValue]];
        [self.tabBar setSelectedViewController:vcProfile];
    }
    
    [self.tabBar changeTabbarBtnWithNum:num];
}

@end
