//
//  AppDelegate.h
//  MyWeiBo
//
//  Created by simplysky on 16/2/29.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWNavigationController.h"
#import "ZWMainTabBarControler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ZWNavigationController *navi;
@property (strong, nonatomic) ZWMainTabBarControler *tabBar;

-(void)gotoHomeViewControl;
-(void)gotoTabBarVcWithNumber:(NSNumber *)num;

@end

