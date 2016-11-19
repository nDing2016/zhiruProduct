//
//  AppDelegate.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "AppDelegate.h"
#import "ZRTabBarViewController.h"
//#import "UIWindow+Share.h"
#import "UIWindow+ZRShare.h"
#import "ZRUser.h"
#import "ZRUserTool.h"
#import "ZRRootTool.h"

#import <PayPalMobile.h>

#import "ZRRegisterViewController.h"
#import <JPUSHService.h>

#import "ZRNewFeatureController.h"
#import "KeychainItemWrapper.h"
#import <AdSupport/ASIdentifierManager.h>
#import "ZRUserInterfaceModel.h"
static NSString *appKey = @"c60715c5e45a958b7dad2063";//申请应用成功以后官方会提供给你

static NSString *channel = @"Publish channel";

static BOOL isProduction = FALSE;


#import <AlipaySDK/AlipaySDK.h>


#import "KeychainItemWrapper.h"
#import <AdSupport/ASIdentifierManager.h>

@interface AppDelegate ()<WXApiDelegate>


@property (nonatomic, copy) NSString *uuidStr;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    //推送
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }else {
//        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//        
        
    }
    
    
// 登录成功后用
//    // 选择根控制器
//    // 判断有没有登录过
//    if ([ZRUserTool user]) { // 已经登录
//
//        // 选择根控制器
//        [ZRRootTool chooseRootViewController:self.window];
//
//    }else{ // 进行登录
//
//
//        // 设置窗口的根控制器 为 登录注册控制器
//
//
//    }
//

//    ZRUser *user = [ZRUserTool user];
//    
//    
//    NSDictionary *dic = @{@"token":@"11111",@"name":@"aaa",@"phone":@"122312"};
//    user = [ZRUser userWithDict:dic];
//    [ZRUserTool saveAccount:user];
//    
//    user = nil;
    
    self.window.rootViewController = [self defaultRootViewController];
    
    
    [GMSServices provideAPIKey:@"AIzaSyAXENF5eHk4MqnyX9WLZ4KNQ7ABWJuZEM0"];
    
    [self.window makeKeyAndVisible];
    
    
    
    //payPal
//    [PayPalMobile
//     initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction
//                                              : @"你的真实交易模式ClientID", PayPalEnvironmentSandbox :
//                                                  @"你的测试模式ClientID"}];
    [PayPalMobile
     initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction
                                              :@"Ab-Het2wAZlgvq8a688nhVC1-80jJEmB13IXvHCP0ckRcRqpsaOfOod9Glcy8DDxevmUI9oEMjA0mRCj", PayPalEnvironmentSandbox :                                                  @"AR3m2FwhssOoQ75fKCVeuviS4Hc2AB01149OghCAR-QGYsFiLxZhARQOcrgStRbTUXRwdfYH12uXl5m6"}];
    

    

    //注册微信支付
    [WXApi registerApp:@"wx9aeecf194e7f7197"];
    
    

    
    
    //share分享

    [self.window share];


    
    
// 极光推送
    //可以添加自定义categories
    
    [JPUSHService registerForRemoteNotificationTypes :( UIUserNotificationTypeBadge |
                                                      
                                                      UIUserNotificationTypeSound |
                                                      
                                                      UIUserNotificationTypeAlert)
     
                                          categories:nil];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    
    //[JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
   
    [IQKeyboardManager sharedManager].enable = YES; // 控制全局键盘遮盖问题,如不想使用 可在具体控制器内 设置为 no

    
   
    
    
    
    return YES;
}

#pragma mark -- 判断是否进入欢迎页

- (UIViewController *)defaultRootViewController {
    if ([self isNewVersion] == YES) {
        //欢迎页
        ZRNewFeatureController * newFeatureCV = [[ZRNewFeatureController alloc] init];
        
        return newFeatureCV;
    }else{
        //首页
        ZRTabBarViewController * tabBarVC = [[ZRTabBarViewController alloc]init];
        
        return tabBarVC;
    }
}


// 获取UUID
- (NSString*)uuid {
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return advertisingId;
}
//// 保存
//- (void)saveUuidWithUserDefaults {
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
//                                         initWithIdentifier:@"UUID" accessGroup:@"com.zhiru.heytang"];
//    NSString *strUUID = [keychainItem objectForKey:(id)kSecValueData];
//    if (strUUID == nil || [strUUID isEqualToString:@""])
//    {
//        [keychainItem setObject:@"MY_APP_CREDENTIALS" forKey:(id)kSecAttrService];
//        [keychainItem setObject:[self uuid] forKey:(id)kSecValueData];
//    }
//    
//    [[NSUserDefaults standardUserDefaults]setObject:self.uuidStr forKey:@"com.zhiru.heytang"];
//    
//    
//}
//// 取保存的UUID
//- (NSString *)getSavedUUID {
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
//                                         initWithIdentifier:@"UUID" accessGroup:@"com.zhiru.heytang"];
//    NSString *strUUID = [keychainItem objectForKey:(id)kSecValueData];
//    return strUUID;
//}



#pragma mark - 极光推送

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    
    // Required
    
    [JPUSHService registerDeviceToken:deviceToken];
    
    
    /*
     
     设置 设置别名（alias）与标签（tags）
     
     别名 alias每个用户只能指定一个别名
     
     标签 tag可为每个用户打多个标签
     
     */
    
//    [JPUSHService setTags:[NSSet setWithObjects:@"tag1",nil] alias:@"testOBU-0000000" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
    


    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.zhiru.heytang"]) {
        self.uuidStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.zhiru.heytang"];
    }else{
        self.uuidStr = [self uuid];
        [[NSUserDefaults standardUserDefaults] setObject:self.uuidStr forKey:@"com.zhiru.heytang"];
    }

    


    
    self.uuidStr = [self.uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];

    self.uuidStr = [self.uuidStr lowercaseString];


    [JPUSHService setTags:[NSSet setWithObjects:@"tag1",nil] alias:self.uuidStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {

        //NSLog(@"iResCode = %d,tags = %@服务器返回的结果：%@",iResCode,iTags,iAlias);
    }];
    
}








//判断版本号

- (BOOL)isNewVersion{
    //获取当前版本
    NSDictionary * dict = [NSBundle mainBundle].infoDictionary;
    double currentVersion = [dict[@"CFBundleShortVersionString"] doubleValue];
    
    //获取上一个版本号
    //设置key
    NSString * boxKey = @"sandBoxKey";
    double lastVersion = [UserDefault doubleForKey:boxKey];
    
    //记录当前系统版本
    [UserDefault setDouble:currentVersion forKey:boxKey];
    [UserDefault synchronize];
    
    //比较两个版本
    return currentVersion > lastVersion;
}






-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:alert
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    
    [JPUSHService handleRemoteNotification:userInfo];
}


//————————————APP正在前台或者后台运行，此函数会被调用————————————//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    WS(ws)
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
        [JPUSHService setBadge:0];
    if (application.applicationState == UIApplicationStateActive) {
        NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        if ([alert isEqualToString:@"您得账号在另一台设备上登陆了"]) {
            
            [ZRAlertControl alertToolWithController:self.window.rootViewController andActionOneTitle:alert andActionTwoTitle:nil andCallBackOne:^{
                //去登录,弹出登录页面
                
                [ws exitUserToken];
                ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
                ZRNavigationController * loginNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                [tab presentViewController:loginNav animated:YES completion:nil];
                
            } andCallBackTwo:^{
                //暂不登录,将用户信息清空掉
                [ws exitUserToken];
            }];
        }
    } else if (application.applicationState == UIApplicationStateInactive) {
        [self exitUserToken];
    } else if (application.applicationState == UIApplicationStateBackground) {
        [self exitUserToken];
    }
    [application setApplicationIconBadgeNumber:0];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    
    
    //Optional
    
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

- (void)exitUserToken{
    [ZRUserTool saveAccount:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userExitLogin" object:@"1"];
}





////ANPs 苹果推送服务器生成的唯一标识
///** 接收服务器传回的设备唯一标识 token */
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    
//    // 第一次运行获取到DeviceToken时间会比较长！
//    // 将deviceToken转换成字符串，以便后续使用
//    NSString *token = [deviceToken description];
//    
//    NSLog(@"description %@", token);
//}
//
////下面方法是当有消息推送回来时,接收推送消息
///** 设备接收到来自苹果推送服务器的消息时触发的,用来显示推送消息 */
//
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    
//    NSLog(@"userInfo == %@",userInfo);
//}
//
////上面方法是当注册推送服务失败时,接收错误信息
///** 注册推送服务失败 */
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    NSLog(@"注册失败 %@",error);
//}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [ZRUserInterfaceModel checkTokenCallBack:^(id result) {
        NSString * tokenMessage = [result objectForKey:@"tokenMassage"];
        if ([tokenMessage isEqualToString:@"无效token"]) {
            [self exitUserToken];
        }
//        if ([tokenMessage isEqualToString:@"无token"]) {
//            NSLog(@"无token");
//        } else if ([tokenMessage isEqualToString:@"token为空"]) {
//            NSLog(@"token为空");
//        } else if ([tokenMessage isEqualToString:@"无效token"]) {
//            NSLog(@"无效token");
//            [self exitUserToken];
//        } else if ([tokenMessage isEqualToString:@"有效token"]) {
//            NSLog(@"有效token");
//        }
    } Failure:^(id error) {
        
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 支付宝支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //NSLog(@"reslut = %@======memo===%@",resultDic,resultDic[@"memo"]);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            //NSLog(@"reslut = %@======memo===%@",resultDic,resultDic[@"memo"]);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            //NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    
    }
    
    
    
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    
    
    if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }else{
        return [self AliPayWithOpenURL:url];
        
    }
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            //NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            //NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    
    NSString *urlKey = [options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"];
    
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    
    if ([urlKey isEqualToString:@"com.malipay.iphoneclient"]) {
        return [self AliPayWithOpenURL:url];
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    
    return YES;
}

//9.0前的方法，为了适配低版本 保留
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    bool a= [WXApi handleOpenURL:url delegate:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kWechatResult_Noti object:nil];
    return a;
}


//Private methods
- (BOOL)AliPayWithOpenURL:(NSURL *)url
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //NSLog(@"result = %@",resultDic);
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            //[SVProgressHUD showSuccessWithStatus:@"支付成功"];
            //支付成功
            [[NSNotificationCenter defaultCenter] postNotificationName:kWechatResult_Noti object:nil];

        }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
            //正在处理中，支付结果未知
            [SVProgressHUD showErrorWithStatus:@"正在处理中，支付结果未知"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
            //订单支付失败
            [SVProgressHUD showErrorWithStatus:@"订单支付失败"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
            //用户中途取消
            [SVProgressHUD showErrorWithStatus:@"用户中途取消"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
            //网络连接出错
            [SVProgressHUD showErrorWithStatus:@"网络连接出错"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else{
            //订单支付失败
            [SVProgressHUD showErrorWithStatus:@"订单支付失败"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }
        
        
        
    }];
    return YES;
}



#pragma mark - WX Delegate
/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(BaseResp *)resp
{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            //NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            //[SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kWechatResult_Noti object:nil];
            
            break;
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            //NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            [SVProgressHUD dismissWithDelay:5];
            break;
    }
}



@end
