//
//  NetworkingUtil.m
//  MyWeiBo
//
//  Created by simplysky on 16/4/14.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "NetworkingUtil.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
//#import "Reachability.h"

@interface NetworkingUtil()

@property(nonatomic,assign) BOOL isNetwokingAvailable;

@end

@implementation NetworkingUtil

NetworkingUtil *util = nil;

+(NetworkingUtil *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[NetworkingUtil alloc] init];
    });
    return util;
}

+(BOOL)bNetStatus
{
    NetworkingUtil *util = [[NetworkingUtil alloc] initWithBaseURL:[NSURL URLWithString:SERVER_IP]];
    [util.reachabilityManager startMonitoring];
    [util setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    
    NSString *netResultStr = [util.reachabilityManager localizedNetworkReachabilityStatusString];
    
    NSLog(@"网络:%@",netResultStr);
    
    if ([netResultStr isEqualToString:@"Reachable via WiFi"] || [netResultStr isEqualToString:@"Rechable via WWAN"]) {
        return true;
    }
    
    if ([netResultStr isEqualToString:@"Not Reachable"] || [netResultStr isEqualToString:@"Unknown"]) {
        [SVProgressHUD showInfoWithStatus:@"当前网络不可用"];
        return false;
    }
    
    return true;
}

+(NSString *)bNetStatusStr
{
    NetworkingUtil *util = [[NetworkingUtil alloc] initWithBaseURL:[NSURL URLWithString:SERVER_IP]];
    [util.reachabilityManager startMonitoring];
    [util setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    
    NSString *netResultStr = [util.reachabilityManager localizedNetworkReachabilityStatusString];
    
    if([netResultStr isEqualToString:@"Reachable via WiFi"])
    {
        return @"WIFI";
    }
    else if([netResultStr isEqualToString:@"Rechable via WWAN"])
    {
        return @"N/A";//@Rechable via WWAN";
    }
    else if([netResultStr isEqualToString:@"Not Reachable"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提 示" message:@"当前网络不可用,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return @"N/A";//@"Not Reachable"
    }
    
    return @"N/A";//@"Unknown Reachable"
}

+(BOOL)isConnectionAvailable
{
//    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
//       ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)) {
//        [SVProgressHUD showInfoWithStatus:@"当前网络不可用"];
//        return NO;
//    }else
//    {
//        return YES;
//    }
    return YES;
}

-(void)setNetworkStatusDelegate:(id<NetworkingUtilDelegate>)delegate
{
    self.delegate = delegate;
    
}


@end
