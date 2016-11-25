//
//  ZRNewAddressViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNewAddressViewController.h"
#import "ZRUserInterfaceModel.h"
#import "ZRLocationViewController.h"
@interface ZRNewAddressViewController ()

//@property (nonatomic, copy)NSString * name;
//@property (nonatomic, copy)NSString * phone;
//@property (nonatomic, copy)NSString * longitude; // 经度
//@property (nonatomic, copy)NSString * latitude; // 维度
@property (nonatomic, copy)NSString * gender;
//@property (nonatomic, copy)NSString * address;

@end

@implementation ZRNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"新增地址"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self createView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];

}
- (void)setPostalCodeStr:(NSString *)postalCodeStr
{
    _postalCodeStr = postalCodeStr;
    //NSLog(@"newaddress=%@, %@", self.administrativeArea, self.postalCodeStr);
    [self.addView.addressView.pitchTextField setText:[NSString stringWithFormat:@"%@,%@", self.administrativeArea, self.postalCodeStr]];
    [self.addView.addressView.textView setText:[NSString stringWithFormat:@"%@,%@", self.street, self.city]];
}
- (void)createView
{
    self.addView = [[ZRNewAddressView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 250)];
    [self.addView.sexView.manButton addTarget:self action:@selector(actionSelectSexButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addView.sexView.womanButton addTarget:self action:@selector(actionSelectSexButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addView.addressView.clearButton addTarget:self action:@selector(actionLocationButton) forControlEvents:UIControlEventTouchUpInside];
    [self.addView setBackgroundColor:RGBCOLOR(255, 255, 255)];
    [self.view addSubview:_addView];
    
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_okButton];
    [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okButton setBackgroundColor:RGBCOLOR(255, 82, 82)];
    self.okButton.layer.masksToBounds = YES;
    self.okButton.layer.cornerRadius = 5;
    [self.okButton addTarget:self action:@selector(actionOkButton) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.addView.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
}
- (void)actionOkButton
{
    
    NSString * name = self.addView.nameView.textField.text;
    NSString * phone = self.addView.phoneNumberView.textField.text;
    NSString * address = [NSString stringWithFormat:@"%@,%@", self.addView.addressView.textView.text, self.addView.addressView.pitchTextField.text];
    NSString * longitude = self.longitude;
    NSString * latitude = self.latitude;
    if (phone.length != 10) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您输入手机号格式有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:action];
        [self.navigationController presentViewController:alertVC animated:YES
                                              completion:nil];
    } else {
        WS(weakSelf);
        [ZRUserInterfaceModel addReceiptAddressWithName:name Phone:phone Longitude:longitude Latitude:latitude Address:address Gender:self.gender UserNewAddressCallBack:^(NSString *message) {
            //NSLog(@"%@", message);
            if ([message isEqualToString:@"success"]) {
                [weakSelf.delegates newAddress];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
- (void)actionSelectSexButton:(UIButton *)sender
{
    if (sender == _addView.sexView.manButton) {
        _addView.sexView.womanButton.selected = NO;
        self.gender = @"0";
        sender.selected = !sender.selected;
    } else {
        self.gender = @"1";
        _addView.sexView.manButton.selected = NO;
        sender.selected = !sender.selected;
    }
}
- (void)actionLocationButton
{
    ZRLocationViewController * locationVC = [[ZRLocationViewController alloc] init];
    [self.navigationController pushViewController:locationVC animated:YES];
}
- (void)tapGesture
{
    [self.view endEditing:YES];
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
