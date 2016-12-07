//
//  ZRPointDetailController.m
//  zhiruProduct
//
//  Created by pj on 16/12/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailController.h"
#import "ZRPointDetailOneCell.h"
#import "ZRPointDetailTwoCell.h"
#import "ZRPointDetailThreeCell.h"
#import "ZRUserPointsRequest.h"
#import "ZRPointOrderDetailModel.h"
#import "ZRStringWithLabel.h"
@interface ZRPointDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)ZRPointOrderDetailModel * modelData;

@end

@implementation ZRPointDetailController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        UIView * view = [UIView new];
        [_tableView setTableFooterView:view];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"积分兑换详情"];
    [self getRequestData];
}
- (void)getRequestData
{
    [CustomHudView show];
    [ZRUserPointsRequest pointDetailOrderId:self.orderId CallBack:^(id result) {
        ZRPointOrderDetailModel * model = result;
        _modelData = model;
        [self.tableView reloadData];
        [CustomHudView dismiss];
    } Failure:^(id error) {
        [AlertText showAndText:@"错误"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 280;
    } else if (indexPath.section == 1) {
        return 160;
    } else {
        CGFloat height;
        if (_modelData.remarks.length == 0) {
            height = [ZRStringWithLabel returanHeightWithText:@"暂无" width:ScreenWidth - 30 font:[UIFont systemFontOfSize:15]];
        } else {
            height = [ZRStringWithLabel returanHeightWithText:_modelData.remarks width:ScreenWidth - 30 font:[UIFont systemFontOfSize:15]];
        }
        return height + 40 + 20;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    [view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * cellId = @"cellOne";
        ZRPointDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
//            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZRPointDetailOneCell class]) owner:self options:nil];
//            cell = [nib lastObject];
            cell = [[ZRPointDetailOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = _modelData;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString * cellId = @"cellTwo";
        ZRPointDetailTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
//            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZRPointDetailTwoCell class]) owner:self options:nil];
//            cell = [nib lastObject];
            cell = [[ZRPointDetailTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = _modelData;
        return cell;
    }
    else {
        static NSString * cellId = @"cell";
        ZRPointDetailThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRPointDetailThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = _modelData;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
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
