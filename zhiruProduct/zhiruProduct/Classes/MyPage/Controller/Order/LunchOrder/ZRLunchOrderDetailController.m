//
//  ZRLunchOrderDetailController.m
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchOrderDetailController.h"
#import "ZRLunchOneCell.h"
#import "ZRLunchTwoCell.h"
#import "ZRLunchThreeCell.h"
#import "ZRLunchFourCell.h"
#import "ZROrderingOrderRequest.h"
#import "ZRLunchOrderDetailModel.h"
#import "ZROrderingDetailsController.h"
@interface ZRLunchOrderDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)ZRLunchOrderDetailModel * dataModel;
@end
@implementation ZRLunchOrderDetailController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"午餐订单详情"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
//    [self.view addSubview:self.tableView];
//    [self getLunchOrderModelRequest];
    [self addHeader];
    if ([self.orderState isEqualToString:@"3"] || [self.orderState isEqualToString:@"4"]) {
        [self creteNavigationRightButton];
    }
}
- (void)creteNavigationRightButton
{
    
    UIButton * rightButton = [MyControl createButtonWithFrame:CGRectMake(5, 0, 39, 44) ImageName:nil Target:self Action:@selector(actionDeleteOrderButton) Title:nil];
    [rightButton setImage:[UIImage imageNamed:@"delegate"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
}
- (void)actionDeleteOrderButton
{
    [ZROrderingOrderRequest deleteLunchOrderWithOrderId:self.orderId CallBack:^(id success) {
        NSString * state = success;
        if ([state isEqualToString:@"success"]) {
            [AlertText showAndText:@"删除成功"];
            [self.delegate deleteOrder];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [AlertText showAndText:@"删除失败"];
        }
    } Failure:^(id error) {
        [AlertText showAndText:@"删除失败"];
    }];
}
- (void)addHeader
{
    [self.tableView startRefreshWithCallback:^{
        
        [self getLunchOrderModelRequest];
    }];
}
- (void)getLunchOrderModelRequest
{
    [ZROrderingOrderRequest myLunchOrderDetailsWithOrderId:_orderId CallBack:^(id success) {
        ZRLunchOrderDetailModel * model = success;
        _dataModel = model;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } Failure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [AlertText showAndText:@"获取失败"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110 + 15;
    } else if (indexPath.section == 1) {
        return 110 + 15 + 30 * self.dataModel.goodsList.count;
    } else if (indexPath.section == 2) {
        return 120 + 15;
    } else {
        return 320 + 15;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * cellId = @"cellId0";
        ZRLunchOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRLunchOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if ([_dataModel.status isEqualToString:@"0"]) { // 未付款
            [cell.orderState setText:@"订单未付款"];
        } else if ([_dataModel.status isEqualToString:@"1"]) {// 等待接单
            [cell.orderState setText:@"订单进行中"];
        } else if ([_dataModel.status isEqualToString:@"2"]) {// 已接单进行中
            [cell.orderState setText:@"订单进行中"];
        } else if ([_dataModel.status isEqualToString:@"3"]) {// 已取消
            [cell.orderState setText:@"订单已取消"];
        } else if ([_dataModel.status isEqualToString:@"4"]) {// 已完成
            [cell.orderState setText:@"订单已完成"];
        }
        [cell.orderTime setText:_dataModel.update_time];
        [cell setBackgroundColor:[UIColor orangeColor]];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString * cellId = @"cellId1";
        ZRLunchTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRLunchTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.menuArray = _dataModel.goodsList;
        [cell.taxMoney setText:[NSString stringWithFormat:@"$%.2f", _dataModel.taxation.floatValue]];
        [cell.allMoney setText:[NSString stringWithFormat:@"$%.2f", _dataModel.canadian_dollar.floatValue]];
        [cell.clearBtn addTarget:self action:@selector(lunchOrderAgain) forControlEvents:UIControlEventTouchUpInside];
        if ([self.orderState isEqualToString:@"0"]) {
            [cell.againButton setTitle:@"取消订单" forState:UIControlStateNormal];
        } else {
            [cell.againButton setTitle:@"再来一单" forState:UIControlStateNormal];
        }
        [cell.againButton addTarget:self action:@selector(lunchOrderStateButton) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section == 2) {
        static NSString * cellId = @"cellId2";
        ZRLunchThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRLunchThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell.nameLabel setText:[NSString stringWithFormat:@"负责人名称: %@", _dataModel.person_name]];
        [cell.phoneLabel setText:[NSString stringWithFormat:@"负责人电话: %@", _dataModel.person_phone]];
        
        [cell setBackgroundColor:[UIColor greenColor]];
        return cell;
    } else {
        static NSString * cellId = @"cellId3";
        ZRLunchFourCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRLunchFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        /*
         [self.orderNumber.titleLabel setText:@"订单号:"];
         [self.name.titleLabel setText:@"联系人:"];
         [self.phone.titleLabel setText:@"联系电话:"];
         [self.address.titleLabel setText:@"取餐地址:"];
         [self.pay.titleLabel setText:@"支付方式:"];
         [self.timer1.titleLabel setText:@"下单时间:"];
         [self.timer2.titleLabel setText:@"取餐时间:"];
         */
//        [cell.orderNumber.titleLabel setText:[NSString stringWithFormat:@"订单号: %@", _dataModel.order_id]];
//        [cell.name.titleLabel setText:[NSString stringWithFormat:@"联系人: %@", _dataModel.take_meal_name]];
//        [cell.phone.titleLabel setText:[NSString stringWithFormat:@"联系电话: %@", _dataModel.take_meal_phone]];
//        [cell.address.titleLabel setText:[NSString stringWithFormat:@"取餐地址: %@", _dataModel.receipt_address]];
//        [cell.pay.titleLabel setText:[NSString stringWithFormat:@"支付方式: %@", _dataModel.pay_method]];
//        [cell.timer1.titleLabel setText:[NSString stringWithFormat:@"下单时间: %@", _dataModel.create_date]];
//        [cell.timer2.titleLabel setText:[NSString stringWithFormat:@"取餐时间: %@", _dataModel.send_time]];
        [cell.orderNumber.contentLabel setText:_dataModel.order_id];
        [cell.name.contentLabel setText:_dataModel.take_meal_name];
        [cell.phone.contentLabel setText:_dataModel.take_meal_phone];
        [cell.address.contentLabel setText:_dataModel.receipt_address];
        [cell.pay.contentLabel setText:_dataModel.pay_method];
        [cell.timer1.contentLabel setText:_dataModel.create_date];
        [cell.timer2.contentLabel setText:[_dataModel.send_time stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        return cell;
    }
}
// 跳转到午餐店铺
- (void)lunchOrderAgain
{
    ZROrderingDetailsController *lunchVC = [[ZROrderingDetailsController alloc] init];
    lunchVC.isLunch = YES;
    [self.navigationController pushViewController:lunchVC animated:YES];
}
- (void)lunchOrderStateButton
{
    if ([self.orderState isEqualToString:@"0"]) {
//        ZRLunchModel * model = [self.dataArray objectAtIndex:sender.tag];
        [ZROrderingOrderRequest cancelOrderWithOrderId:_dataModel.order_id CallBack:^(id success) {
            NSString * message = success;
            if ([message isEqualToString:@"success"]) {
                [AlertText showAndText:@"取消成功"];
                [self.delegate cancelLunchOrderId];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [AlertText showAndText:@"取消订单失败"];
            }
        } Failure:^(id error) {
            [AlertText showAndText:@"取消订单失败"];
        }];
    } else {
        ZROrderingDetailsController *lunchVC = [[ZROrderingDetailsController alloc] init];
        lunchVC.isLunch = YES;
        [self.navigationController pushViewController:lunchVC animated:YES];
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
