//
//  ZRLoginViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//


// 登录
#import "ZRLoginViewController.h"
#import "ZRRegisterViewController.h"
#import "ZRHomeController.h"
#import "ZRLoginView.h"
#import "ZRForgetPasswordViewController.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUserTool.h"
#import "ZRUser.h"
#import "KeychainItemWrapper.h"
#import <AdSupport/ASIdentifierManager.h>
#import "NSString+Password.h"
@interface ZRLoginViewController ()

@property (nonatomic, strong)ZRLoginView * userNameView;
@property (nonatomic, strong)ZRLoginView * passWordView;
@property (nonatomic, strong)UIButton * loginButton;

//设备唯一标识
@property (nonatomic, copy) NSString * registrationId;
@end

@implementation ZRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"登录"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    // 创建导航栏左侧按钮
    [self createNavigaitionLeftButton];
    // 创建导航栏右侧按钮
    [self createNavigationRightButton];
    // 创建用户名视图
    [self createUserNameView];
    // 创建密码师徒
    [self createPasswordView];
    // 创建线
    [self createLineView];
    // 创建登录按钮
    [self createLoginButton];
    // 创建忘记密码按钮
    [self createForgetPassWordButton];
    
    
}

- (void)createUserNameView
{
    self.userNameView = [[ZRLoginView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 40.0 / 667.0 * ScreenHeight)];
    self.userNameView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.userNameView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_userNameView];
    
    [self.userNameView labelText:@"账号" labelTextFont:16 textFieldPlaceHolder:@"请输入手机号" textFieldSecureTextEntry:NO];
    [self.userNameView.textField setBorderStyle:UITextBorderStyleNone];
    [self.userNameView.textField setClearButtonMode:UITextFieldViewModeAlways];
}
- (void)createPasswordView
{
    self.passWordView = [[ZRLoginView alloc] initWithFrame:CGRectMake(0, _userNameView.frame.origin.y + self.userNameView.frame.size.height, ScreenWidth, _userNameView.frame.size.height)];
    [self.passWordView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_passWordView];
    
    [self.passWordView labelText:@"密码" labelTextFont:16 textFieldPlaceHolder:@"6-32位字母数字组合" textFieldSecureTextEntry:YES];
    [self.passWordView.textField setBorderStyle:UITextBorderStyleNone];
    [self.passWordView.textField setClearButtonMode:UITextFieldViewModeAlways];
}
- (void)createLineView
{
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [line1 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.userNameView addSubview:line1];
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [line2 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.passWordView addSubview:line2];
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.passWordView.frame.size.height - 1, ScreenWidth, 1)];
    [line3 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.passWordView addSubview:line3];
}
- (void)createLoginButton
{
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_loginButton];
    WS(weakSelf);
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.passWordView.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5.;
    self.loginButton.backgroundColor = RGBCOLOR(255, 82, 82);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(actionLoginButton) forControlEvents:UIControlEventTouchUpInside];
}
// 点击登录按钮
- (void)actionLoginButton
{
    
    [self.userNameView.textField resignFirstResponder];
    [self.passWordView.textField resignFirstResponder];
    
    if (self.userNameView.textField.text.length == 0) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号不能输入为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (self.passWordView.textField.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码不能输入为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString * userNameStr = self.userNameView.textField.text;
        NSString * password = [self.passWordView.textField.text myMD5];



//        NSString * registrationId;
//        if ([self getKeychain].length > 0) {
//            registrationId = [self getKeychain];
//        } else {
//            registrationId = [self uuid];
//            [self saveUuidWithKeyChain];
//        }
//
//        NSLog(@"+++++%@", registrationId);






        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.zhiru.heytang"]) {
            self.registrationId = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.zhiru.heytang"];
        }else{
            self.registrationId = [self uuid];
            [[NSUserDefaults standardUserDefaults] setObject:self.registrationId forKey:@"com.zhiru.heytang"];
        }
        
        
        self.registrationId = [self.registrationId stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        self.registrationId = self.registrationId.lowercaseString;
        
//        NSLog(@"ppppppp: %@", self.registrationId);
//        NSLog(@"===%@", self.registrationId);

        WS(weakSelf);

        self.loginButton.userInteractionEnabled = NO;

        [ZRUserInterfaceModel loginWithPassword:password UserName:userNameStr RegistrationId:self.registrationId LoginCallBack:^(NSString *message, id data) {
            self.loginButton.userInteractionEnabled = YES;
            if ([message isEqualToString:@"success"]) {
                NSDictionary * dic = data;
                //NSLog(@"--------%@", dic);
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    ZRUser * user = [ZRUser userWithDict:dic];
                    BOOL state = [ZRUserTool saveAccount:user];
                    if (state == YES) {
                        [self.delegate userLogin];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }
                }]];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                
                
            } else if ([message isEqualToString:@"不存在用户"]) {
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号不存在" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                
            } else if ([message isEqualToString:@"手机或密码错误"]) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            
        }];
    }
}




// 获取UUID
- (NSString*)uuid {
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return advertisingId;
    
}
//- (void)saveUuidWithKeyChain {
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
//                                         initWithIdentifier:@"UUID" accessGroup:@"com.zhiru.heytang"];
//    NSString *strUUID = [keychainItem objectForKey:(id)kSecValueData];
//    if (strUUID == nil || [strUUID isEqualToString:@""])
//    {
//        [keychainItem setObject:self.registrationId forKey:(id)kSecValueData];
//        
//    }
//    
//    
//}
//
////从keychain获取UUID
//- (NSString *)getKeychain {
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
//                                         initWithIdentifier:@"UUID" accessGroup:@"com.zhiru.heytang"];
//    NSString *strUUID = [keychainItem objectForKey:(id)kSecValueData];
//    return strUUID;
//}
//












- (void)createForgetPassWordButton
{
    UIButton * forgetPassWord = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:forgetPassWord];
    WS(weakSelf);
    [forgetPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.loginButton);
        make.top.equalTo(weakSelf.loginButton.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
    [forgetPassWord setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPassWord setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    [forgetPassWord.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [forgetPassWord addTarget:self action:@selector(actionForgetPassWordButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassWord];
    
}
// 忘记密码
- (void)actionForgetPassWordButton
{
    ZRForgetPasswordViewController * forgetPasswordVC = [[ZRForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
- (void)createNavigaitionLeftButton
{
    UIBarButtonItem * item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"cha"] highImage:[UIImage imageNamed:@"cha"]  target:self action:@selector(actionLeftButton)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)actionLeftButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createNavigationRightButton
{
    UIButton * rightButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 40, 40) ImageName:nil Target:self Action:@selector(actionRightButton) Title:@"注册"];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightButton setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
// 点击注册
- (void)actionRightButton
{
    ZRRegisterViewController * regiseterVC = [[ZRRegisterViewController alloc] init];
    [self.navigationController pushViewController:regiseterVC animated:YES];
    
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
