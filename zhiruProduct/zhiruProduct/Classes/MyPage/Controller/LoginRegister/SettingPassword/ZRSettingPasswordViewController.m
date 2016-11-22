//
//  ZRSettingPasswordViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//



#import "ZRSettingPasswordViewController.h"
#import "ZRUserInterfaceModel.h"
#import "NSString+Password.h"
@interface ZRSettingPasswordViewController ()





@end

@implementation ZRSettingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置新密码"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    [self createNewPassword];
    [self createAgainPassword];
    [self createButton];
    [self createLineView];
    
    
    
}

- (void)createNewPassword
{
    self.passWord = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 40.0 / 667.0 * ScreenHeight)];
    self.passWord.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_passWord];
    [self.passWord labelText:@"新密码" labelTextFont:15 textFieldPlaceHolder:@"6-32位字母数字组合" textFieldSecureTextEntry:YES];
    [self.passWord.textField setClearButtonMode:UITextFieldViewModeAlways];
}
- (void)createAgainPassword
{
    CGFloat y = _passWord.frame.origin.y;
    CGFloat height = _passWord.frame.size.height;
    self.againPassWord = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, y + height, ScreenWidth, height)];
    self.againPassWord.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_againPassWord];
    [self.againPassWord labelText:@"再次输入" labelTextFont:15 textFieldPlaceHolder:@"再次输入" textFieldSecureTextEntry:YES];
    [self.againPassWord.textField setClearButtonMode:UITextFieldViewModeAlways];
}
- (void)createButton
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    WS(weakSelf);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.againPassWord.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    self.button.backgroundColor = RGBCOLOR(255, 82, 82);
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(actionButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)actionButton
{
    [self.passWord.textField resignFirstResponder];
    [self.againPassWord.textField resignFirstResponder];
    NSString * newPassword = [self.passWord.textField.text myMD5];
    NSString * againPassword = [self.againPassWord.textField.text myMD5];
    WS(weakSelf);
    if (self.passWord.textField.text.length <= 5 || self.againPassWord.textField.text.length >= 31) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码输入格式有误" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if ([newPassword isEqualToString:againPassword] && ![newPassword isEqualToString:@""]) {
        [ZRUserInterfaceModel retrievePswWithPhone:self.phone NewPassword:newPassword CallBack:^(NSString *message) {
            [AlertText showAndText:@"修改成功"];
            UIViewController * vc = [weakSelf.navigationController.viewControllers objectAtIndex:0];
            [weakSelf.navigationController popToViewController:vc animated:YES];
            
        } Failure:^(id error) {
            [AlertText showAndText:@"修改失败"];
        }];
    } else if ([newPassword isEqualToString:@""] || [againPassword isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"输入密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (![newPassword isEqualToString:againPassword]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"两次输入的密码不相同, 请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];

    }
}
- (void)createLineView
{
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView1.backgroundColor = RGBCOLOR(240, 239, 245);
    [_passWord addSubview:lineView1];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView2.backgroundColor = RGBCOLOR(240, 239, 245);
    [_againPassWord addSubview:lineView2];
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, _passWord.frame.size.height + 1, ScreenWidth, 1)];
    lineView3.backgroundColor = RGBCOLOR(240, 239, 245);
    [_againPassWord addSubview:lineView3];
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
