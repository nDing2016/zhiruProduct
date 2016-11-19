//
//  ZRTradingViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//


// 我的钱包-交易记录
#import "ZRTradingViewController.h"
#import "ZRTradingTableViewCell.h"
#import "ZRBillViewController.h"
@interface ZRTradingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tradingTableView;
@property (nonatomic, strong)NSArray * sectionArray;

@end

@implementation ZRTradingViewController

- (UITableView *)tradingTableView
{
    if (_tradingTableView == nil) {
        _tradingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tradingTableView];
        UIView * view = [[UIView alloc] init];
        _tradingTableView.tableFooterView = view;
    }
    return _tradingTableView;
}
- (NSArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSArray arrayWithObjects:@"2016年7月",@"2016年6月", nil];
    }
    return _sectionArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"交易记录"];
    
    [self.tradingTableView setDelegate:self];
    [self.tradingTableView setDataSource:self];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionArray objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0 / 667.0 * ScreenHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tradingCellID = @"tradingCellID";
    ZRTradingTableViewCell * tradingCell = [tableView dequeueReusableCellWithIdentifier:tradingCellID];
    if (tradingCell == nil) {
        tradingCell = [[ZRTradingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tradingCellID];
    }
    tradingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tradingCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBillViewController * billVC = [[ZRBillViewController alloc] init];
    [self.navigationController pushViewController:billVC animated:YES];
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
