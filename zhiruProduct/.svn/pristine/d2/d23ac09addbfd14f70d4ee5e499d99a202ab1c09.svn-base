//
//  ZRSuperOrderDetailsController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSuperOrderDetailsController.h"
#import "ZROrderDetailsRequest.h"
#import "ZRSuperDetailsModel.h"
#import "ZRSupermarketHomeController.h"

#import "ZRSupermarketHomeModel.h"

#import "ZRSupermarketOrderViewController.h"


@interface ZRSuperOrderDetailsController ()

@property (nonatomic, strong) ZRSuperDetailsModel *superDetailsModel;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation ZRSuperOrderDetailsController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    //删除订单
    [self setUpNavigationRightDeleteBtn];
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //下拉加载
    [self.tableView startRefreshWithCallback:^{
        
        [self loadNewDatas];
        
    }];
    
    
    
}

-(void)setUpNavigationRightDeleteBtn
{
    
    _deleteBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(deleteBtnClick:) Title:nil];
    [_deleteBtn setImage:ZRImage(@"delegate") forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_deleteBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
}



#pragma mark - click methods
/**
 *  删除订单
 */
- (void)deleteBtnClick:(UIButton *)btn
{
    
    if (self.canDelete == YES) {
        [SVProgressHUD show];
        [ZROrderDetailsRequest requestForKaDeleteOrderWithOrderId:self.orderIdStr Callback:^(id details, NSError *error) {
            
            if ([details[@"message"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
                
                [self performSelector:@selector(popThisPage) withObject:nil afterDelay:1];
                

            }else{
               [SVProgressHUD dismiss]; 
            }
            
            
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"订单不能删除"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
    }
    
    
    
    
}



- (void)popThisPage
{
    [self.navigationController popViewControllerAnimated:YES];
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isMemberOfClass:[ZRSupermarketOrderViewController class]]) {
            ZRSupermarketOrderViewController *zrVC = (ZRSupermarketOrderViewController *)vc;
            [zrVC addHeaderRequest];
        }
    }
    
}


#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络请求获取数据
- (void)loadNewDatas
{
    WS(ws)
    [ZROrderDetailsRequest requestForMyKaOrderDetailsWithOrderId:self.orderIdStr Callback:^(id details, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        if (details) {
            ws.superDetailsModel = [ZRSuperDetailsModel mj_objectWithKeyValues:details];
            self.sectionNum = 4;
            
            if ([ws.superDetailsModel.status isEqualToString:@"0"]) {
                self.orderDetailsStr = @"订单进行中";
            }else if ([ws.superDetailsModel.status isEqualToString:@"1"]){
                self.orderDetailsStr = @"订单已取消";
            }else if ([ws.superDetailsModel.status isEqualToString:@"2"]){
                self.orderDetailsStr = @"订单已完成";
            }
            
            // 订单状态更新时间
            self.orderTime = ws.superDetailsModel.update_time;
            //超市名称
            self.nameStr = ws.superDetailsModel.ka_name;
            
//            self.productsArr = @[@[@"XXXXXXXXXXXX",@"x1",@"$5"],@[@"XXXXXXXXXXXX",@"x1",@"$5"],@[@"XXXXXXXXXXXX",@"x1",@"$5"]];
            self.productsArr = ws.superDetailsModel.goodsList;
            
            self.orderDetailsType = OrderDetailsSupermarket;
            self.kaDetailModel = ws.superDetailsModel;
            [self.tableView reloadData];
        }
        
        
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //跳转到超市到家页面
            ZRSupermarketHomeController *superHomeVC = [[ZRSupermarketHomeController alloc] init];
            [self.navigationController pushViewController:superHomeVC animated:YES];
            ZRSupermarketHomeModel *homeModel = [[ZRSupermarketHomeModel alloc] init];
            homeModel.kaId = self.superDetailsModel.ka_id;
            superHomeVC.supermarketModel = homeModel;
        }
    }
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
