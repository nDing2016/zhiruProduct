//
//  ZRNameViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNameViewController.h"

@interface ZRNameViewController ()



@end

@implementation ZRNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@"修改昵称"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self createContentView];
}

-(void)setNameAndIphone:(updateType)nameAndIphone{
    _nameAndIphone = nameAndIphone;
    
}

- (void)createContentView
{
    
    self.nameView = [[ZRRegisterView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 40.0)];
    [self.nameView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.nameView];
    if (_nameAndIphone == ZRIphone) {
        [self.nameView labelText:@"电话" labelTextFont:16 textFieldPlaceHolder:@"请输入电话号" textFieldSecureTextEntry:NO];
        self.title = @"修改手机号";
        self.nameView.isPhone = YES;
         self.okButton.tag = 1;
    }else{
        [self.nameView labelText:@"昵称" labelTextFont:16 textFieldPlaceHolder:@"请输入昵称" textFieldSecureTextEntry:NO];
        self.okButton.tag = 0;
    }

    if (![self.name isEqualToString:@""]) {
        self.nameView.textField.text = self.name;
    }
    
 
    
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.okButton];
    WS(weakSelf);
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.nameView.mas_bottom).with.offset(25);
        make.height.equalTo(@40);
    }];
    [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okButton setBackgroundColor:RGBCOLOR(255, 82, 82)];
    self.okButton.layer.masksToBounds = YES;
    self.okButton.layer.cornerRadius = 5;
    [self.okButton addTarget:self action:@selector(actionOkButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)actionOkButton:(UIButton*)btn
{
    if (btn.tag == 1) {
        //修改电话
        
        if (![self textOnlyNumber:  self.nameView.textField.text ]) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号只能为数字" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if([self.nameView.textField.text isEqualToString:@""] || self.nameView.textField.text.length!=10 ){
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            self.clickBaocun(self.nameView.textField.text);
        }
    }else{
        if (![self.nameView.textField.text isEqualToString:@""]) {
            if (self.clickBaocun) {
                self.clickBaocun(self.nameView.textField.text);
            }
            [self.delegate sendNameString:self.nameView.textField.text];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"昵称不能输入为空" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
   
}

//判断是否只有 数字  包含其他字符返回NO
-(BOOL)textOnlyNumber: (NSString*) number{
    
    BOOL res = YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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