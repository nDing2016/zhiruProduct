//
//  ZRAlterAddressViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAlterAddressViewController.h"
#import "ZRUserAddressModel.h"
#import "ZRUserInterfaceModel.h"
@interface ZRAlterAddressViewController ()<UITextViewDelegate>

@end

@implementation ZRAlterAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改地址"];
    [self.addView.nameView.textField setText:self.model.name];
    if (self.model.gender == 0) {
        [self.addView.sexView.manButton setSelected:YES];
        [self.addView.sexView.womanButton setSelected:NO];
        
    } else if (self.model.gender == 1) {
        [self.addView.sexView.womanButton setSelected:NO];
        [self.addView.sexView.manButton setSelected:YES];
    }
    [self.addView.phoneNumberView.textField setText:_model.phone];
    
//    if ([_sex isEqualToString:@"先生"]) {
//        [self.addView.sexView.manButton setSelected:YES];
//        [self.addView.sexView.womanButton setSelected:NO];
//    }
//    [self.addView.phoneNumberView.textField setText:_phoneNumber];
//    
    [self.addView.addressView.textView setText:_model.address];
    [self.addView.addressView.textView setDelegate:self];
    [self.addView.addressView.textView setTextColor:[UIColor blackColor]];
    [self.addView.addressView.textView setFont:[UIFont systemFontOfSize:15]];
    [self.okButton addTarget:self action:@selector(actionOkButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self createNavigationRightButton];
}
- (void)setAdministrativeAreaAlter:(NSString *)administrativeAreaAlter
{
    _administrativeAreaAlter = administrativeAreaAlter;
    [self.addView.addressView.pitchTextField setText:[NSString stringWithFormat:@"%@,%@", self.administrativeAreaAlter, self.postalCodeStrAlter]];
    [self.addView.addressView.textView setText:[NSString stringWithFormat:@"%@,%@", self.streetAlter, self.cityAlter]];
}
- (void)actionOkButton
{
    NSString * ID = self.model.addressId;
    NSString * name = self.addView.nameView.textField.text;
    NSString * phone = self.addView.phoneNumberView.textField.text;
    NSString * longitude;
    if (self.longitudeAlter.length == 0) {
        longitude = self.model.longitude;
    } else {
        longitude = self.longitudeAlter;
    }
    NSString * latitude;
    if (self.latitudeAlter.length == 0) {
        latitude = self.model.latitude;
    } else {
        latitude = self.latitudeAlter;
    }
    NSString * address = [NSString stringWithFormat:@"%@,%@", self.addView.addressView.textView.text, self.addView.addressView.pitchTextField.text];
    NSString * gender;
    if (self.addView.sexView.manButton.selected == YES && self.addView.sexView.womanButton.selected == NO) {
        gender = @"0";
    }
    if (self.addView.sexView.manButton.selected == NO && self.addView.sexView.womanButton.selected == YES) {
        gender = @"1";
    }
    NSString * isdefault = @"0";
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
        [ZRUserInterfaceModel updateReceiptAddressWithID:ID Name:name Phone:phone Longitude:longitude Latitude:latitude Address:address Gender:gender Isdefault:isdefault UserUpdateAddressCallBack:^(NSString *message) {
            if ([message isEqualToString:@"success"]) {
                
                [weakSelf.delegate alterSuccess];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }
    
}








- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"详细地址(如门牌号等)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        [textView setFont:[UIFont systemFontOfSize:15]];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = @"详细地址(如门牌号等)";
        [textView setFont:[UIFont systemFontOfSize:14]];
        textView.textColor = RGBCOLOR(136, 136, 136);
    }
}
- (void)createNavigationRightButton
{
    UIImage * image = [UIImage imageNamed:@"delegate"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(deleteButton)];
}
- (void)deleteButton
{
    WS(weakSelf);
    [ZRUserInterfaceModel delReceiptAddressWithId:self.model.addressId CallBack:^(NSString *message) {
        if ([message isEqualToString:@"success"]) {
            [AlertText showAndText:@"删除成功"];
            [weakSelf.delegate deleteAddress];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [AlertText showAndText:@"删除失败"];
        }
    } Failure:^(id error) {
        [AlertText showAndText:@"删除失败"];
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
