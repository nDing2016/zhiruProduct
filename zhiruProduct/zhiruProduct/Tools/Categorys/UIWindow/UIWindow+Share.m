//
//  UIWindow+Share.m
//  Exercise
//
//  Created by ddlu on 15/11/2.
//  Copyright © 2015年 liuyang. All rights reserved.
//

#import "UIWindow+Share.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@implementation UIWindow (Share)

- (void)share{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:SHARESDK_APP_KEY
          activePlatforms:@[@(SSDKPlatformTypeQQ), @(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                             
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType) {
                      
                  case SSDKPlatformTypeWechat:
                  {
                      [appInfo SSDKSetupWeChatByAppId:WX_APP_KEY
                                            appSecret:WX_App_Secret];
                  }
                      break;
                      
                  case SSDKPlatformTypeQQ:
                  {
                      [appInfo SSDKSetupQQByAppId:QQ_APP_KEY
                                           appKey:QQ_App_Secret
                                         authType:SSDKAuthTypeSSO];
                  }
                      break;
                      
                  case SSDKPlatformTypeSinaWeibo:
                  {
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:SINA_APP_KEY
                                                appSecret:SINA_App_Secret
                                              redirectUri:SINA_REDIRECTURI
                                                 authType:SSDKAuthTypeBoth];
                  }
                      break;
                      
                  default:
                      break;
              }
          }];
    
}



@end
