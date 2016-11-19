//
//  ZRAlertControl.m
//  zhiruProduct
//
//  Created by nanding on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAlertControl.h"

@implementation ZRAlertControl

/**
 *  未登录弹出框
 *  @param ctl 控制器
 */
+(void)notLoginAlert:(UIViewController *)ctl goLogin:(AlertCallback)callback;
{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"用户未登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (callback) {
            callback();
        }
        
    }];
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"暂时不登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertCtl addAction:alertAction];
    [alertCtl addAction:cancelAlert];
    
    [ctl presentViewController:alertCtl animated:YES completion:nil];
    
}

+ (void)alertToolWithController: (UIViewController *)viewController andActionOneTitle :(NSString *)titleOne andActionTwoTitle :(NSString *)titleTwo andCallBackOne :(AlertCallback)oneBack andCallBackTwo :(AlertCallback)twoBack{
    
      UIAlertController * alertV = [UIAlertController alertControllerWithTitle:titleOne message:titleTwo preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (oneBack) {
            oneBack();
        }

    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"暂不登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertV addAction:action];
    [alertV addAction:cancel];
    
    [viewController presentViewController:alertV animated:YES completion:^{
        
    }];
}


/**
 *  汇率提示alert
 *
 *  @param viewController 控制器
 *  @param title          汇率提示
 *  @param btnOneCallback 去支付回调
 */
+ (void)alertForRateWithController:(UIViewController *)viewController andActionTitle:(NSString *)title andButtonOneCallBack:(AlertCallback)btnOneCallback
{
    UIAlertController * alertV = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"去支付" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (btnOneCallback) {
            btnOneCallback();
        }
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"暂不支付" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertV addAction:action];
    [alertV addAction:cancel];
    
    [viewController presentViewController:alertV animated:YES completion:^{
        
    }];
    
}








@end
