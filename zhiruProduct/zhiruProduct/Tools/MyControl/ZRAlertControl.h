//
//  ZRAlertControl.h
//  zhiruProduct
//
//  Created by nanding on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertCallback)();

@interface ZRAlertControl : NSObject

/**
 *  未登录弹出框
 *  @param ctl 控制器
 */
+(void)notLoginAlert:(UIViewController *)ctl goLogin:(AlertCallback)callback;

/**
 *  两个按钮提示框
 *
 *  @param viewController 控制器
 *  @param titleOne       按钮1
 *  @param titleTwo       按钮2
 *  @param oneBack        按钮1 的回调
 *  @param twoBack        按钮2 的回调
 */
+ (void)alertToolWithController: (UIViewController *)viewController andActionOneTitle :(NSString *)titleOne andActionTwoTitle :(NSString *)titleTwo andCallBackOne :(AlertCallback)oneBack andCallBackTwo :(AlertCallback)twoBack;


/**
 *  汇率提示alert
 *
 *  @param viewController 控制器
 *  @param title          汇率提示
 *  @param btnOneCallback 去支付回调
 */
+ (void)alertForRateWithController:(UIViewController *)viewController andActionTitle:(NSString *)title andButtonOneCallBack:(AlertCallback)btnOneCallback;



/**
 *  定位提示
 *
 *  @param myWindow       <#myWindow description#>
 *  @param title          <#title description#>
 *  @param btnOneCallback <#btnOneCallback description#>
 */
+ (void)alertToolWithLocationWithWindow:(id)myWindow andActionTitle:(NSString *)title  andText:(NSString *)text andButtonOneCallBack:(AlertCallback)btnOneCallback;


@end
