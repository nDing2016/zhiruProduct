//
//  ZRWithdrawCashController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWithdrawCashController.h"

@interface ZRWithdrawCashController ()
@property (nonatomic , assign) CGRect lastViewRect;
@end

@implementation ZRWithdrawCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ZRBackgroundColor;
    [self createWithdrawCashView];
    
}

- (void)createWithdrawCashView{
    CGFloat backX = 0;
    CGFloat backW= ScreenWidth;
    CGFloat backH = 44;
    for (int i = 0; i < 2; i++) {
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(backX, 64 + 20+ i * backH, backW, backH)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        UILabel * titleLB = [[UILabel alloc] init];
        if (i==0) {
            titleLB.text = @"银行卡:";
        }else{
            titleLB.text = @"再次输入:";
        }
        
        titleLB.font = [UIFont systemFontOfSize:14];
        [backView addSubview:titleLB];
        
        UITextField * bankNumb = [[UITextField alloc]init];
        bankNumb.font = [UIFont systemFontOfSize:14];
        bankNumb.placeholder = @"请输入您要提现的银行卡号";
        [backView addSubview:bankNumb];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = R_G_B_16(0xbbbbbb);
        [backView addSubview:lineView];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left).offset(15);
            make.centerY.equalTo(backView.mas_centerY);
        }];
        
        [bankNumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(backView.mas_centerY);
            make.left.equalTo(backView.mas_left).offset(80);
            make.right.equalTo(backView.mas_right).offset(-15);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left);
            make.right.equalTo(backView.mas_right);
            make.bottom.equalTo(backView.mas_bottom);
            make.height.equalTo(@1);
        }];
        
        if (i==0) {
            UIView * lineView = [[UIView alloc] init];
            lineView.backgroundColor = R_G_B_16(0xbbbbbb);
            [backView addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_left);
                make.right.equalTo(backView.mas_right);
                make.top.equalTo(backView.mas_top);
                make.height.equalTo(@1);
            }];
        }
        
        _lastViewRect = backView.frame;
    }
    
    //确定按钮
    UIButton * submitBtn = [MyControl createButtonWithFrame:CGRectMake(35, CGRectGetMaxY(_lastViewRect) + 50, ScreenWidth - 70, 40) ImageName:nil Target:self Action:@selector(countBtnClick:) Title:@"确定"];
    
    submitBtn.tag = 100;
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [submitBtn setBackgroundColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:submitBtn];
}

- (void)countBtnClick :(UIButton *)btn{
    
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
