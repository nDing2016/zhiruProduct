//
//  ZRAlterPhoneViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAlterPhoneViewController.h"
#import "ZRVerificationPhoneViewController.h"
#import "ZRUserTool.h"
#import "ZRUser.h"
@interface ZRAlterPhoneViewController ()

@end

@implementation ZRAlterPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"修改手机号"];
    ZRUser * uesr = [ZRUserTool user];
    [self.nameView labelText:@"手机号" labelTextFont:16 textFieldPlaceHolder:@"请输入手机号" textFieldSecureTextEntry:NO];
    [self.nameView.textField setText:uesr.phone];
    [self.nameView.textField setUserInteractionEnabled:NO];
    [self.okButton setTitle:@"修改手机号" forState:UIControlStateNormal];
//    [self.okButton addTarget:self action:@selector(actionOkButton) forControlEvents:UIControlEventTouchUpInside];
}
//- (void)actionOkButton
//{
//    
//}
- (void)actionOkButton:(UIButton*)btn
{
    ZRVerificationPhoneViewController * phoneVC = [[ZRVerificationPhoneViewController alloc] init];
    phoneVC.phone = self.nameView.textField.text;
    [self.navigationController pushViewController:phoneVC animated:YES];
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
