//
//  ZRWalletPasswordViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWalletPasswordViewController.h"
#import "ZROriginalViewController.h"
#import "ZRForgetWalletViewController.h"
@interface ZRWalletPasswordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;
@end

@implementation ZRWalletPasswordViewController


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 80.0 / 667.0 * ScreenHeight) style:UITableViewStylePlain];
        [_tableView setScrollEnabled:NO];
        [self.view addSubview:_tableView];
        UIView * view = [[UIView alloc] init];
        [view setBackgroundColor:RGBCOLOR(240, 240, 240)];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"修改支付密码",@"忘记支付密码", nil];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"密码管理"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0 / 667.0 * ScreenHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * walletCellID = @"walletCellID";
    UITableViewCell * walletCell = [tableView dequeueReusableCellWithIdentifier:walletCellID];
    if (walletCell == nil) {
        walletCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletCellID];
    }
    [walletCell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [walletCell.textLabel setText:[self.dataArray objectAtIndex:indexPath.row]];
    walletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    walletCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return walletCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZROriginalViewController * originalVC = [[ZROriginalViewController alloc] init];
        [self.navigationController pushViewController:originalVC animated:YES];
    } else if (indexPath.row == 1) {
        ZRForgetWalletViewController * forgetVC = [[ZRForgetWalletViewController alloc] init];
        [self.navigationController pushViewController:forgetVC animated:YES];
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
