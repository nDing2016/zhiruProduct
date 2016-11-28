//
//  ZRSupermarketOrderViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketOrderViewController.h"
#import "ZRSupermarketOrderCell.h"

#import "ZRSuperOrderDetailsController.h"
#import "ZRMyOrderViewController.h"

#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZROrderingOrderRequest.h"
#import "ZRSuperOderModel.h"
#import "ZRPaymentOrderController.h"
#import "ZRAddKaOrderModel.h"
#import "ZRSupermarketHomeModel.h"
#import "ZRSupermarketHomeController.h"
@interface ZRSupermarketOrderViewController ()

@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZRSupermarketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    [self addHeaderRequest];
}
- (void)addHeaderRequest
{
    [self.tableView startRefreshWithCallback:^{
        [self dataOrderList];
    }];
}
- (void)dataOrderList
{
    [ZROrderingOrderRequest myKaOrderWithCallBack:^(id success) {
        [self.dataArray removeAllObjects];
        self.dataArray = success;
        if (self.dataArray.count == 0) {
            [self createImage];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } Failure:^(id error) {
        [AlertText showAndText:@"获取失败"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"supermarket";
    ZRSupermarketOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRSupermarketOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = [self.dataArray objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.commentButton.tag = indexPath.section;
    cell.againButton.tag = indexPath.section;
    [cell.commentButton addTarget:self action:@selector(superOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.againButton addTarget:self action:@selector(superAgainButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
// 超市未支付去支付
- (void)superOrderButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"去付款"]) {
        ZRSuperOderModel * model = [self.dataArray objectAtIndex:sender.tag];
        [CustomHudView show];
        [ZROrderingOrderRequest kaCreateSignOrderUrlWithOrderId:model.orderId CallBack:^(id success) {
            [CustomHudView dismiss];
            ZRAddKaOrderModel * kaModel = success;
            ZRPaymentOrderController * orderVC = [[ZRPaymentOrderController alloc] init];
            orderVC.addKaOrderModel = kaModel;
            orderVC.payOrderType = 2;
            orderVC.payPrice = [NSString stringWithFormat:@"$%.2f", kaModel.price.floatValue];
            ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            ZRNavigationController *nav  = tab.childViewControllers[2];
            ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
            [myOrdreVC.navigationController pushViewController:orderVC animated:YES];
        } Failure:^(id error) {
            [CustomHudView dismiss];
            [AlertText showAndText:@"错误"];
        }];
//        [ZROrderingOrderRequest createSignOrderUrlWithOrderId:model.orderId Total:model.canadianDollar CallBack:^(id success) {
//            
//            
//        } Failure:^(id error) {
//            
//        }];
    }
}
// 超市再来一单或取消订单
- (void)superAgainButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        //NSLog(@"取消订单");
        ZRSuperOderModel * orderModel = [self.dataArray objectAtIndex:sender.tag];
        [ZROrderingOrderRequest kaCanacelOrderWithOrderId:orderModel.orderId CallBack:^(id success) {
            NSString * message = success;
            if ([message isEqualToString:@"success"]) {
                [AlertText showAndText:@"取消成功"];
                [self addHeaderRequest];
            } else {
                [AlertText showAndText:@"取消订单失败"];
            }
        } Failure:^(id error) {
             [AlertText showAndText:@"取消订单失败"];
        }];
    } else {
        ZRSuperOderModel * orderModel = [self.dataArray objectAtIndex:sender.tag];
        ZRSupermarketHomeController * superVC = [[ZRSupermarketHomeController alloc] init];
        ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        ZRNavigationController *nav  = tab.childViewControllers[2];
        ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
        ZRSupermarketHomeModel * model = [[ZRSupermarketHomeModel alloc] init];
        model.kaId = orderModel.kaId;
        model.kaName = orderModel.kaName;
        superVC.supermarketModel = model;
        [myOrdreVC.navigationController pushViewController:superVC animated:YES];
    }
}
#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRSuperOderModel * model = [self.dataArray objectAtIndex:indexPath.section];
    
    ZRSuperOrderDetailsController *orderDetailsVC = [[ZRSuperOrderDetailsController alloc] init];
    orderDetailsVC.orderIdStr = model.orderId;
    if ([model.process isEqualToString:@"25"] || [model.process isEqualToString:@"24"] || [model.process isEqualToString:@"26"]) {
        orderDetailsVC.canDelete = YES;
    }else{
        orderDetailsVC.canDelete = NO;
    }
    
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    
    [myOrdreVC.navigationController pushViewController:orderDetailsVC animated:YES];
    
    
}
// 添加暂无订单图片
- (void)createImage
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50)];
    [img setImage:[UIImage imageNamed:@"noorder"]];
    [self.view addSubview:img];
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
