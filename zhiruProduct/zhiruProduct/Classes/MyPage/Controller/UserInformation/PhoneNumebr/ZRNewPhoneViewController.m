//
//  ZRNewPhoneViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNewPhoneViewController.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUserTool.h"
@interface ZRNewPhoneViewController ()

@end

@implementation ZRNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"修改手机号"];
    [self.phoneNumber.textField setPlaceholder:@"请输入新手机号"];
    [self.registerButton setTitle:@"提交" forState:UIControlStateNormal];
    
}
- (void)actionCaptcha
{
    
    NSString * phoneNumber = self.phoneNumber.textField.text;
//    NSString * areaPhone = self.phoneNumber.label.text;
    NSArray * array = [self.phoneNumber.label.text componentsSeparatedByString:@"+"];
    NSString * areaPhone = [array lastObject];
    [ZRUserInterfaceModel getNewPhoneVCodePhone:phoneNumber AreaPhone:areaPhone CodeStyle:@"3" CallBack:^(NSString *message) {
        [AlertText showAndText:message];
    } Failure:^(id error) {
        [AlertText showAndText:@"发送失败"];
    }];
    WS(weakSelf);
    __block int timeout=60; //倒计时时间
    if (![phoneNumber isEqualToString:@""]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [weakSelf.phoneNumber.captchaButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                    weakSelf.phoneNumber.captchaButton.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [weakSelf.phoneNumber.captchaButton setTitle:[NSString stringWithFormat:@"重新发送(%@)",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    weakSelf.phoneNumber.captchaButton.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    } else {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)actionRegisterButton
{
    NSString * phoneNumber = self.phoneNumber.textField.text;
//    NSArray * array = [self.phoneNumber.label.text componentsSeparatedByString:@"+"];
//    NSString * areaPhone = [array lastObject];
    NSString * vCode = self.captacha.textField.text;
    [ZRUserInterfaceModel updatePhoneWithPhone:phoneNumber VCode:vCode CallBack:^(NSString *message) {
        //NSLog(@"%@", message);
        if ([message isEqualToString:@"success"]) {
            [AlertText showAndText:@"修改成功"];
            [ZRUserTool saveAccount:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userExit" object:@"1"];
            UIViewController * vc = [self.navigationController.viewControllers objectAtIndex:0];
            [self.navigationController popToViewController:vc animated:YES];
        }
    } Failure:^(id error) {
        [AlertText showAndText:@"修改失败"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
