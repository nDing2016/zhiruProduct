//
//  ZRSuccessViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSuccessViewController.h"
#import "ZRRechargeSuccessView.h"
@interface ZRSuccessViewController ()

@property (nonatomic, strong)ZRRechargeSuccessView * headerView;
@property (nonatomic, strong)UIButton * button;
@end

@implementation ZRSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setTitle:@"充值成功"];
    
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self createView];
    [self setViewMasonary];
    
}
- (void)createView
{
    self.headerView = [[ZRRechargeSuccessView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 320)];
    [self.headerView.fangshi.titleLabel setText:@"充值方式"];
    [self.headerView.fangshi.contentLabel setText:@"Paypal"];
    [self.headerView.jine.titleLabel setText:@"充值金额"];
    [self.headerView.jine.contentLabel setText:@"$20.00"];
    [self.view addSubview:_headerView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    [self.button setTitle:@"完成" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setBackgroundColor:RGBCOLOR(255, 82, 82)];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.headerView.jine.mas_bottom).with.offset(25);
        make.height.mas_equalTo(@40);
    }];
}
- (void)buttonClick
{
    UIViewController * vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
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
