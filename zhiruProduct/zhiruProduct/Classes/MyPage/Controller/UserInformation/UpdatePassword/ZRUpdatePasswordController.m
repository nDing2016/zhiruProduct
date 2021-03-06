//
//  ZRUpdatePasswordController.m
//  zhiruProduct
//
//  Created by pj on 16/9/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUpdatePasswordController.h"
#import "ZRRegisterView.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUserTool.h"
#import "NSString+Password.h"
@interface ZRUpdatePasswordController ()

@property (nonatomic, strong)ZRRegisterView * oldPsW;

@property (nonatomic, strong)ZRRegisterView * neWPsw;

@property (nonatomic, strong)ZRRegisterView * againPsw;

@property (nonatomic, strong)UIButton * button;

@end

@implementation ZRUpdatePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改密码"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self createView];
}
- (void)createView
{
    self.oldPsW = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 40)];
    [self.oldPsW setBackgroundColor:[UIColor whiteColor]];
    [self.oldPsW labelText:@"原密码" labelTextFont:16 textFieldPlaceHolder:@"请输入原密码" textFieldSecureTextEntry:YES];
    [self.view addSubview:_oldPsW];
    self.oldPsW.textField.clearButtonMode = UITextFieldViewModeAlways;
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [line1 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.oldPsW addSubview:line1];
    
    self.neWPsw = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, 40)];
    [self.neWPsw setBackgroundColor:[UIColor whiteColor]];
    [self.neWPsw labelText:@"新密码" labelTextFont:16 textFieldPlaceHolder:@"6-32位字母数字组合" textFieldSecureTextEntry:YES];
    self.neWPsw.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_neWPsw];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [line2 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.neWPsw addSubview:line2];
    
    self.againPsw = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 170, ScreenWidth, 40)];
    [self.againPsw setBackgroundColor:[UIColor whiteColor]];
    [self.againPsw labelText:@"再次输入" labelTextFont:16 textFieldPlaceHolder:@"请重复输入密码" textFieldSecureTextEntry:YES];
    self.againPsw.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_againPsw];
    
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [line3 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.againPsw addSubview:line3];
    
    UIView * line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 210, ScreenWidth, 1)];
    [line4 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.view addSubview:line4];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    WS(weakSelf);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.againPsw.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    self.button.backgroundColor = RGBCOLOR(255, 82, 82);
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(actionUpdatePswButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)actionUpdatePswButton
{
    [self.oldPsW.textField resignFirstResponder];
    [self.neWPsw.textField resignFirstResponder];
    [self.againPsw.textField resignFirstResponder];
    NSString * oldPsw = self.oldPsW.textField.text;
    NSString * newPsw = self.neWPsw.textField.text;
    NSString * againPsw = self.againPsw.textField.text;
    if ([oldPsw isEqualToString:@""] || [newPsw isEqualToString:@""] || [againPsw isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"输入密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (![newPsw isEqualToString:againPsw]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"两次密码输入不同, 请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (newPsw.length <= 5 || newPsw.length >= 31) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新密码格式有误, 请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [ZRUserInterfaceModel updatePswWithOldPwd:[oldPsw myMD5] NewPwd:[newPsw myMD5] CallBack:^(NSString *message) {
            if ([message isEqualToString:@"success"]) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"修改成功, 请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    [ZRUserTool saveAccount:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userExit" object:@"1"];
                    UIViewController * vc = [self.navigationController.viewControllers objectAtIndex:0];
                    [self.navigationController popToViewController:vc animated:YES];
                    
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                
            } else if ([message isEqualToString:@"原密码错误"]) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"原密码错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                [AlertText showAndText:@"修改失败"];
            }
        } failure:^(id error) {
            [AlertText showAndText:@"修改失败"];
        }];
    }
    
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
