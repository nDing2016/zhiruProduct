//
//  ZRSelectViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectViewController.h"
#import "ZRSelectTableViewCell.h"
#import "ZRSuccessViewController.h"
@interface ZRSelectViewController ()


@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * lineView1;
@property (nonatomic, strong)ZRSelectTableViewCell * paypal;
@property (nonatomic, strong)UIView * lineView2;
@property (nonatomic, strong)ZRSelectTableViewCell * weixin;
@property (nonatomic, strong)UIView * lineView3;
@property (nonatomic, strong)ZRSelectTableViewCell * zhifubao;
@property (nonatomic, strong)UIView * lineView4;
@property (nonatomic, strong)UIButton * rechargeButton;//立即充值
@end

@implementation ZRSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"充值"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self createView];
    [self setViewMasonary];
}
- (void)createView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 150)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
    self.paypal = [[ZRSelectTableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [self.backView addSubview:_paypal];
    [self.paypal.selectButton addTarget:self action:@selector(actionPayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.weixin = [[ZRSelectTableViewCell alloc] initWithFrame:CGRectMake(0, _paypal.frame.size.height, ScreenWidth, 50)];
    [self.backView addSubview:_weixin];
    
    
    [self.weixin.selectButton addTarget:self action:@selector(actionPayButton:) forControlEvents:UIControlEventTouchUpInside];
    self.zhifubao = [[ZRSelectTableViewCell alloc] initWithFrame:CGRectMake(0, _weixin.frame.origin.y + _weixin.frame.size.height, ScreenWidth, 50)];
    [self.backView addSubview:_zhifubao];
    [self.zhifubao.selectButton addTarget:self action:@selector(actionPayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView1 = [[UIView alloc] init];
    [self.backView addSubview:_lineView1];
    self.lineView1.backgroundColor = RGBCOLOR(187, 187, 187);
    
    self.lineView2 = [[UIView alloc] init];
    [self.backView addSubview:_lineView2];
    self.lineView2.backgroundColor = RGBCOLOR(187, 187, 187);
    
    self.lineView3 = [[UIView alloc] init];
    [self.backView addSubview:_lineView3];
    self.lineView3.backgroundColor = RGBCOLOR(187, 187, 187);
    
    self.lineView4 = [[UIView alloc] init];
    [self.backView addSubview:_lineView4];
    self.lineView4.backgroundColor = RGBCOLOR(187, 187, 187);
    
    self.rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_rechargeButton];
    [self.rechargeButton setTitle:@"立即充值" forState:UIControlStateNormal];
    [self.rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rechargeButton setBackgroundColor:RGBCOLOR(255, 82, 82)];
    self.rechargeButton.layer.masksToBounds = YES;
    self.rechargeButton.layer.cornerRadius = 5;
    [self.rechargeButton addTarget:self action:@selector(actionRechargeButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).with.offset(0);
        make.top.equalTo(weakSelf.backView).with.offset(0);
        make.right.equalTo(weakSelf.backView).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.weixin);
        make.left.equalTo(weakSelf.backView).with.offset(60);
        make.right.equalTo(weakSelf.backView).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.zhifubao);
        make.left.equalTo(weakSelf.backView).with.offset(60);
        make.right.equalTo(weakSelf.backView).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backView);
        make.left.equalTo(weakSelf.backView);
        make.right.equalTo(weakSelf.backView);
        make.height.mas_equalTo(@1);
    }];
    
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.top.equalTo(weakSelf.backView.mas_bottom).with.offset(25);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.height.mas_equalTo(@40);
    }];
}
- (void)actionPayButton:(UIButton *)sender
{
    if (sender == _paypal.selectButton) {
        sender.selected = !sender.selected;
        [_weixin.selectButton setSelected:NO];
        [_zhifubao.selectButton setSelected:NO];
    } else if (sender == _weixin.selectButton) {
        sender.selected = !sender.selected;
        [_paypal.selectButton setSelected:NO];
        [_zhifubao.selectButton setSelected:NO];
    } else if (sender == _zhifubao.selectButton) {
        sender.selected = !sender.selected;
        [_paypal.selectButton setSelected:NO];
        [_weixin.selectButton setSelected:NO];
    }
}
- (void)actionRechargeButton
{
    ZRSuccessViewController * successVC = [[ZRSuccessViewController alloc] init];
    [self.navigationController pushViewController:successVC animated:YES];
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
