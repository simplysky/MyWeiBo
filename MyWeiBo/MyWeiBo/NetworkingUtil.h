//
//  NetworkingUtil.h
//  MyWeiBo
//
//  Created by simplysky on 16/4/14.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

#define SERVER_IP @"http://www.baidu.com"

@protocol NetworkingUtilDelegate <NSObject>

/*
 * YES -网络可用; NO - 网络不可用
 */
-(void)availableForNetwork:(BOOL)isAvailable;

@end

@interface NetworkingUtil : AFHTTPRequestOperationManager

@property(nonatomic,assign)id<NetworkingUtilDelegate> delegate;

+(NetworkingUtil *)sharedInstance;

/*
 * @breif 网络状态是否可用
 * @return YES - 可用 NO - 不可用
 */
+(BOOL)bNetStatus;

/*
 * @breif 返回网络状态
 * @return 返回的网络状态
 */
+(NSString *)bNetStatusStr;

/*
 * @breif 检查网络是否可用
 */
+(BOOL)isConnectionAvailable;

//-(void)checkNetworkStatus:(NSNotification *)note;

@end
