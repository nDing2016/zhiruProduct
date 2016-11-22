//
//  ZRUpDataIphoneNumbController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUpDataIphoneNumbController.h"

@interface ZRUpDataIphoneNumbController ()

@end

@implementation ZRUpDataIphoneNumbController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUpDataView];
    
    self.view.backgroundColor = ZRBackgroundColor;
}

- (void)createUpDataView{
    
    CGFloat backX = 0;
    CGFloat backW= ScreenWidth;
    CGFloat backH = 44;

    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(backX, 64 + 20, backW, backH)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];

    
    UILabel * titleLB = [UILabel new];
    titleLB.text = @"手机号";
    titleLB.font = [UIFont systemFontOfSize:14];
    [backView addSubview:titleLB];
    
    
    UITextField * newIphone = [[UITextField alloc] init];
    newIphone.text = @"原先手机号";
    newIphone.font = [UIFont systemFontOfSize:14];
    [backView addSubview:newIphone];
    
    UIView * topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = R_G_B_16(0xbbbbbb);
    [backView addSubview:topLineView];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = R_G_B_16(0xbbbbbb);
    [backView addSubview:bottomLineView];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(15);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    [newIphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLB.mas_right).offset(30);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(backView.mas_top);
        make.height.equalTo(@1);
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.bottom.equalTo(backView.mas_bottom);
        make.height.equalTo(@1);
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
