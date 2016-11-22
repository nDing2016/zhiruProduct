//
//  ZRRootTool.m
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRootTool.h"
#import "ZRTabBarViewController.h"

#define VersionKey @"version"

@implementation ZRRootTool

// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 创建tabBarVc
        ZRTabBarViewController *tabBarVc = [[ZRTabBarViewController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
        
    }else{ // 有最新的版本号
        
        // 如果有新特性，进入新特性界面
        
        
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
    }
}



@end
