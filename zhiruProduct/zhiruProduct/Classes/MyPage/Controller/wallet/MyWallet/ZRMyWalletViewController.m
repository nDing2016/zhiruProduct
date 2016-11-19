//
//  ZRMyWalletViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyWalletViewController.h"
#import "ZRMyWalletHeaderView.h"
#import "ZRRechargeViewController.h"
#import "ZRTradingViewController.h"
#import "ZRWalletPasswordViewController.h"
#import "ZRWithdrawCashController.h"
#import "ZRBecomeVipController.h"
#import "ZRWalletRuleController.h"
@interface ZRMyWalletViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong)UITableView * walletTableView;
@property (nonatomic, strong)NSArray * dataArray;
@end

@implementation ZRMyWalletViewController


- (UITableView *)walletTableView
{
    if (_walletTableView == nil) {
        _walletTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_walletTableView];
        ZRMyWalletHeaderView * headerView = [[ZRMyWalletHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 178.0 / 667.0 * ScreenHeight)];
        self.walletTableView.tableHeaderView = headerView;
        UIView * view = [[UIView alloc] init];
        _walletTableView.tableFooterView = view;
    }
    return _walletTableView;
}
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"成为会员",@"交易记录",@"密码管理",@"提现", nil];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的钱包"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    
#pragma mark 等功能完事之后再解开注释
//    [self.walletTableView setDelegate:self];
//    [self.walletTableView setDataSource:self];
//    [self createRightNavigate];
#pragma mark 等功能完善之后再去掉蒙版图片
    [self createNoOpenImage];
    
}
- (void)createNoOpenImage
{
    UIImageView * image = [[UIImageView alloc] init];
    [image setImage:ZRImage(@"qingqidai")];
    [self.view addSubview:image];
    WS(weakSelf);
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
    }];
}
- (void)createRightNavigate
{
    UIButton * button = [MyControl createButtonWithFrame:CGRectMake(0, 0, 60, 40) ImageName:nil Target:self Action:@selector(walletRule) Title:@"钱包规则"];
    
    [button setTitleColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)walletRule
{
    ZRWalletRuleController * walletRule = [[ZRWalletRuleController alloc] init];
    [self.navigationController pushViewController:walletRule animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"钱包服务";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:R_G_B_16(0xfafafa)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth, 27)];
    [label setText:@"钱包服务"];
    [label setTextColor:R_G_B_16(0x555555)];
    [label setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:label];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * walletCellID = @"walletCellID";
    UITableViewCell * walletCell = [tableView dequeueReusableCellWithIdentifier:walletCellID];
    if (walletCell == nil) {
        walletCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletCellID];
    }
    [walletCell.textLabel setText:[self.dataArray objectAtIndex:indexPath.row]];
    [walletCell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    [walletCell.textLabel setTextColor:R_G_B_16(0x555555)];
    walletCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    walletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return walletCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //购买余额劵
//        ZRRechargeViewController * recharge = [[ZRRechargeViewController alloc] init];
//        [self.navigationController pushViewController:recharge animated:YES];
        ZRBecomeVipController * becomeVip = [[ZRBecomeVipController alloc] init];
        [self.navigationController pushViewController:becomeVip animated:YES];
        
    } else if (indexPath.row == 1) {
        ZRTradingViewController * trading = [[ZRTradingViewController alloc] init];
        [self.navigationController pushViewController:trading animated:YES];
    } else if (indexPath.row == 2) {
        ZRWalletPasswordViewController * walletPass = [[ZRWalletPasswordViewController alloc] init];
        [self.navigationController pushViewController:walletPass animated:YES];
        
    } else if(indexPath.row == 3){ //提现
        //NSLog(@"提现");
        ZRWithdrawCashController * withdrawCashVC = [[ZRWithdrawCashController alloc] init];
        [self.navigationController pushViewController:withdrawCashVC animated:YES];
        
        withdrawCashVC.title = @"提现";
    }
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
