//
//  ZROrderDetailsController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderDetailsController.h"
#import "ZROrderFormStatusController.h"
#import "ZROrderDetailsCell.h"

@interface ZROrderDetailsController ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation ZROrderDetailsController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}


#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger num;
    if (self.orderDetailsType == OrderDetailsSupermarket || self.orderDetailsType == OrderDetailsOrdering) {
        num = 4;
    }else if (self.orderDetailsType == OrderDetailsGroupBuying){
        num = self.orderFormArr.count;
    }
    return num;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    if (self.orderDetailsType == OrderDetailsGroupBuying) {
        num = [self.orderFormArr[section] count];
    }else if (self.orderDetailsType == OrderDetailsOrdering || self.orderDetailsType == OrderDetailsSupermarket){
        if (section == 0) {
            num = 1;
        }else if (section == 1){
            num = 4;
        }else if(section == 2){
            num = 3;
        }else{
            num = 7;
        }

    }
    return num;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZROrderDetailsCell *cell = [ZROrderDetailsCell cellWithTable:self.tableView ForIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //防止重用
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.superDetailsModel = nil;
    cell.productsArr = nil;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.idxPath = indexPath;
    cell.orderType = self.orderDetailsType;
    
    
    if (self.orderDetailsType == OrderDetailsGroupBuying) {
        cell.orderDetailsArray = self.orderFormArr;
        
    }else if (self.orderDetailsType == OrderDetailsOrdering || self.orderDetailsType == OrderDetailsSupermarket){
        
        if (indexPath.section == 0) {
            cell.imageView.image = ZRImage(@"chaoshi");
            
            cell.textLabel.text = self.orderDetailsStr;
            
            //            switch (self.orderStatus) {
            //                case 0:
            //                {
            //                    cell.textLabel.text = @"订单提交成功";
            //                }
            //                    break;
            //                case 1:
            //                {
            //                    cell.textLabel.text = @"订单已支付";
            //                }
            //                    break;
            //                case 2:
            //                {
            //                    cell.textLabel.text = @"等待商户接单";
            //                }
            //                    break;
            //                case 3:
            //                {
            //                    cell.textLabel.text = @"商家已经确认订单";
            //                }
            //                    break;
            //                case 4:
            //                {
            //                    cell.textLabel.text = @"骑士已取货";
            //                }
            //                    break;
            //                case 5:
            //                {
            //                    cell.textLabel.text = @"订单已完成";
            //                }
            //                    break;
            //    
            //                default:
            //                    break;

            
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
            cell.detailTextLabel.text = self.orderTime;
            //更多状态按钮
            UIButton *moreStatusBtn = [[UIButton alloc] init];
            [moreStatusBtn setTitle:@"更多状态>>" forState:UIControlStateNormal];
            [moreStatusBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            moreStatusBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:moreStatusBtn];
            [moreStatusBtn addTarget:self action:@selector(moreStatusClick:) forControlEvents:UIControlEventTouchUpInside];
            CGSize size = [NSString getSize:@"更多状态>> " strFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(ScreenWidth,ScreenHeight)];
            [moreStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-15));
                make.top.equalTo(@15);
                make.size.mas_equalTo(size);
            }];
        }else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.textLabel.text = self.nameStr;
                cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                
                cell.productsArr = self.productsArr;
                [cell setSuperDetailsModel:self.kaDetailModel];
                
            
            }
            
        }else{
           [cell setSuperDetailsModel:self.kaDetailModel]; 
        }

        
    }
    

    return cell;
}

#pragma mark - UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (self.orderDetailsType == OrderDetailsSupermarket || self.orderDetailsType == OrderDetailsOrdering) {
        
        if (indexPath.section == 0) {
            height = ZRImage(@"Default").size.height+20;
        }else if (indexPath.section == 1){
            if (indexPath.row == 0 || indexPath.row == 3) {
                height = 40*SCREEN_HEIGHT/667;
            }else if (indexPath.row == 1){
                height = (30*self.productsArr.count+10)*SCREEN_HEIGHT/667;
            }else{
                height = 85*SCREEN_HEIGHT/667;
            }
            
        }else if (indexPath.section == 2){
            height = 40*SCREEN_HEIGHT/667;
        }else{
            height = 40*SCREEN_HEIGHT/667;
        }

        
    }else if (self.orderDetailsType == OrderDetailsGroupBuying){
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                height = ZRImage(@"Default").size.height+20;
            }else{
                height = 40*SCREEN_HEIGHT/667;
            }
            
        }else if (indexPath.section == 1){
            height = 40*SCREEN_HEIGHT/667;
        }else if (indexPath.section == 2){
            if (indexPath.row == 0) {
                height = 40*SCREEN_HEIGHT/667;
            }else{
                height = 25*SCREEN_HEIGHT/667;
            }
        }else if (indexPath.section == 3){
            if (indexPath.row == 0) {
                height = 40*SCREEN_HEIGHT/667;
            }else{
                height = 20*SCREEN_HEIGHT/667;
            }
        }else if (indexPath.section == 4){
            if (indexPath.row == 0) {
                height = 40*SCREEN_HEIGHT/667;
                
            }else{
                height = 320*SCREEN_HEIGHT/667;
            }
        }
        
    }
    
    return height;
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat h;
    if (section == 0) {
        h = 0.1;
    }else{
        h = 15;
    }
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat h;
    if (self.orderDetailsType == OrderDetailsGroupBuying) {
        if (section == 4) {
            h = 70*SCREEN_HEIGHT/667;
        }
    }
    return h;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view;
    if (self.orderDetailsType == OrderDetailsGroupBuying) {
        if (section == 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70*SCREEN_HEIGHT/667)];
            UIButton *payBackBtn = [[UIButton alloc] init];
            payBackBtn.backgroundColor = RGBCOLOR(255, 82, 82);
            [payBackBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [payBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            payBackBtn.titleLabel.font = CustomFont(15);
            payBackBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            payBackBtn.layer.cornerRadius = 5.0;
            [payBackBtn addTarget:self action:@selector(payBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:payBackBtn];
            __block CGFloat w = ((SCREEN_WIDTH-45)/2);
            [payBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@15);
                make.top.equalTo(@15);
                make.height.equalTo(@(40*SCREEN_HEIGHT/667));
                make.width.equalTo(@(w));
                
            }];
            
            
            //再次购买
            UIButton *reBuyBtn = [[UIButton alloc] init];
            reBuyBtn.backgroundColor = RGBCOLOR(255, 82, 82);
            [reBuyBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            [reBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            reBuyBtn.titleLabel.font = CustomFont(15);
            reBuyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            reBuyBtn.layer.cornerRadius = 5.0;
            [reBuyBtn addTarget:self action:@selector(reBuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:reBuyBtn];
            [reBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-15));
                make.top.equalTo(@15);
                make.height.equalTo(@(40*SCREEN_HEIGHT/667));
                make.width.equalTo(@(w));
                
            }];
        }
        
    }
    return view;
}


#pragma mark - Private methods


#pragma mark - click methods
- (void)moreStatusClick:(UIButton *)sender
{
    ZROrderFormStatusController *orderStatusVC = [[ZROrderFormStatusController alloc] init];
    [self.navigationController pushViewController:orderStatusVC animated:YES];
    
    orderStatusVC.orderIdStr = self.kaDetailModel.order_id;
    orderStatusVC.orderPrice = [NSString stringWithFormat:@"%.2f",[self.kaDetailModel.canadian_dollar floatValue]];
    orderStatusVC.riderPhoneStr = self.kaDetailModel.rider_phone;
}

/**
 *  申请退款
 */
- (void)payBackBtnClick:(UIButton *)sender
{
    
}

/**
 *  再次购买
 */
- (void)reBuyBtnClick:(UIButton *)sender
{
    
}

#pragma mark - manage memory methods
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
