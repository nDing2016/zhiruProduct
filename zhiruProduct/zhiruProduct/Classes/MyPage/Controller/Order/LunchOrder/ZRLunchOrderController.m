//
//  ZRLunchOrderController.m
//  zhiruProduct
//
//  Created by pj on 16/10/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchOrderController.h"
#import "ZROrderingOrderRequest.h"
#import "ZROrderingOrderCell.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRMyOrderViewController.h"

#import "ZROrderingDetailsController.h"
#import "ZRLunchOrderDetailController.h"
#import "ZRPaymentOrderController.h"
#import "ZRLunchModel.h"
#import "ZRAddKaOrderModel.h"
@interface ZRLunchOrderController ()<ZRLunchOrderDetailDelegate>

@property (nonatomic, strong)NSMutableArray * dataArray;

@end
@implementation ZRLunchOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    [self addHeaderRequest];
}
- (void)addHeaderRequest
{
    [self.tableView startRefreshWithCallback:^{
        [self requestData];
    }];
}
- (void)requestData
{
    [ZROrderingOrderRequest myLunchOrderWithCallBack:^(id success) {
        [self.dataArray removeAllObjects];
        self.dataArray = success;
        if (self.dataArray.count == 0) {
            [self createImage];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } Failure:^(id error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"ordering";
    ZROrderingOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZROrderingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commentButton.tag = indexPath.section;
    [cell.commentButton addTarget:self action:@selector(orderingCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.againButton.tag = indexPath.section;
    [cell.againButton addTarget:self action:@selector(againLunchButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.lunchModel = [self.dataArray objectAtIndex:indexPath.section];
    return cell;
}

// 未付款午餐订单去付款
- (void)orderingCommentButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"去付款"]) {
        ZRLunchModel * model = [self.dataArray objectAtIndex:sender.tag];
        [CustomHudView show];
        [ZROrderingOrderRequest createSignOrderUrlWithOrderId:model.orderId Total:model.canadianDollar CallBack:^(id success) {
            [CustomHudView dismiss];
            ZRAddKaOrderModel * kamodel = success;
            ZRPaymentOrderController * orderVC = [[ZRPaymentOrderController alloc] init];
            orderVC.addKaOrderModel = kamodel;
            orderVC.payOrderType = 2;
            orderVC.payPrice = [NSString stringWithFormat:@"$%.2f", kamodel.price.floatValue];
            ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            ZRNavigationController *nav  = tab.childViewControllers[2];
            ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
            [myOrdreVC.navigationController pushViewController:orderVC animated:YES];
        } Failure:^(id error) {
            [CustomHudView dismiss];
            [AlertText showAndText:@"错误"];
        }];
    }
}
- (void)againLunchButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        [CustomHudView show];
        ZRLunchModel * model = [self.dataArray objectAtIndex:sender.tag];
        [ZROrderingOrderRequest cancelOrderWithOrderId:model.orderId CallBack:^(id success) {
            [CustomHudView dismiss];
            NSString * message = success;
            if ([message isEqualToString:@"success"]) {
                [AlertText showAndText:@"取消成功"];
                [self addHeaderRequest];
            } else {
                [AlertText showAndText:@"取消订单失败"];
            }
        } Failure:^(id error) {
            [CustomHudView dismiss];
            [AlertText showAndText:@"取消订单失败"];
        }];
    } else {
        ZROrderingDetailsController *lunchVC = [[ZROrderingDetailsController alloc] init];
        lunchVC.isLunch = YES;
        ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        ZRNavigationController *nav  = tab.childViewControllers[2];
        ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
        [myOrdreVC.navigationController pushViewController:lunchVC animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRLunchModel * model = [self.dataArray objectAtIndex:indexPath.section];
     ZRLunchOrderDetailController * lunchOrder = [[ZRLunchOrderDetailController alloc] init];
    lunchOrder.orderId = model.orderId;
    lunchOrder.orderState = model.status;
    lunchOrder.delegate = self;
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    [myOrdreVC.navigationController pushViewController:lunchOrder animated:YES];
}
// 午餐订单详情取消订单代理方法
- (void)cancelLunchOrderId
{
    [self addHeaderRequest];
}
// 午餐订单详情删除订单代理方法
- (void)deleteOrder
{
    [self addHeaderRequest];
}
// 添加暂无订单图片
- (void)createImage
{
//    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50)];
//    [img setImage:[UIImage imageNamed:@"noorder"]];
//    [self.view addSubview:img];
    UIImageView * img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:@"noorder"]];
    [self.view addSubview:img];
    WS(weakSelf);
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
    }];
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
