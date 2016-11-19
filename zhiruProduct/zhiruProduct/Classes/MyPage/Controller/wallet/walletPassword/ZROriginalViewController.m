//
//  ZROriginalViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROriginalViewController.h"
#import "ZRRegisterView.h"
#import "ZRNewWalletPasswordViewController.h"
@interface ZROriginalViewController ()


@property (nonatomic, strong)ZRRegisterView * originalPassword;

@property (nonatomic, strong)UIButton * okButton;
@end

@implementation ZROriginalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改密码"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self createView];
    [self setViewMasonary];
}
- (void)createView
{
    self.originalPassword = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 40.0 / 667.0 * ScreenHeight)];
    self.originalPassword.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_originalPassword];
    [self.originalPassword labelText:@"原密码" labelTextFont:16 textFieldPlaceHolder:@"请输入原密码" textFieldSecureTextEntry:NO];
    [self.originalPassword.textField setClearButtonMode:UITextFieldViewModeAlways];
    
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_okButton];
    [self.okButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okButton setBackgroundColor:RGBCOLOR(255, 82, 82)];
    self.okButton.layer.masksToBounds = YES;
    self.okButton.layer.cornerRadius = 5;
    [self.okButton addTarget:self action:@selector(actionOkButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.originalPassword.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
}
- (void)actionOkButton
{
    ZRNewWalletPasswordViewController * newWalletVC = [[ZRNewWalletPasswordViewController alloc] init];
    [self.navigationController pushViewController:newWalletVC animated:YES];
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
