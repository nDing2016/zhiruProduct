//
//  ZRRefundStateController.m
//  zhiruProduct
//
//  Created by pj on 16/9/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRefundStateController.h"
#import "ZRRefundHeaderView.h"
#import "ZRRefundSectionView.h"
#import "ZRRefundCell.h"
#import "ZRRefundHelpController.h"
@interface ZRRefundStateController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@end

@implementation ZRRefundStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"退款状态"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        ZRRefundHeaderView * headerView = [[ZRRefundHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
        [_tableView setTableHeaderView:headerView];
        
        UIView * view = [UIView new];
        [_tableView setTableFooterView:view];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZRRefundSectionView * sectionView = [[ZRRefundSectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView.clearButton addTarget:self action:@selector(actionSectionClearButton) forControlEvents:UIControlEventTouchUpInside];
    return sectionView;
}
// 退款帮助
- (void)actionSectionClearButton
{
    ZRRefundHelpController * helpVC = [[ZRRefundHelpController alloc] init];
    [self.navigationController pushViewController:helpVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    ZRRefundCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ZRRefundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        cell.state1 = YES;
    }
    if (indexPath.row == 3) {
        cell.state2 = YES;
    }
    return cell;
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
