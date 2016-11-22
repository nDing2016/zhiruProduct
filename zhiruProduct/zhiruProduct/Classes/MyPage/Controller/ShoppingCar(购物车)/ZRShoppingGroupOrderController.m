//
//  ZRShoppingGroupOrderController.m
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingGroupOrderController.h"
#import "ZRTuanOneCell.h"
#import "ZRTuanTotalCell.h"
#import "ZRTuanPhoneCell.h"
#import "ZRShoppingCarDetailModel.h"
#import "ZRUserTool.h"
#import "ZRUser.h"
@interface ZRShoppingGroupOrderController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@end

@implementation ZRShoppingGroupOrderController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"提交订单"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        [_tableView setTableFooterView:view];
        
        UIButton * submitOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitOrderButton setFrame:CGRectMake(40, 30, ScreenWidth - 80, 40)];
        [view addSubview:submitOrderButton];
        [submitOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [submitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitOrderButton.backgroundColor = RGBCOLOR(255, 82, 82);
        submitOrderButton.layer.masksToBounds = YES;
        submitOrderButton.layer.cornerRadius = 5;
        [submitOrderButton addTarget:self action:@selector(actionSubmitOrderButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.allArray.count) {
        return 41;
    }
//    else if (indexPath.section == self.allArray.count + 1) {
//        return 81;
//    }
    else {
        return 121;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.allArray.count) {
        static NSString * cellId1 = @"cellId1";
        ZRTuanTotalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (cell == nil) {
            cell = [[ZRTuanTotalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        }
        
        CGFloat allMoney;
        for (ZRShoppingCarDetailModel * model in self.allArray) {
            int num = model.num.intValue;
            CGFloat nowPrice = model.nowPrice.floatValue;
            CGFloat money = num * nowPrice;
            allMoney += money;
        }
        [cell.totalMoneyLabel setText:[NSString stringWithFormat:@"$%.2f", allMoney]];
        return cell;
    }
//        else if (indexPath.section == self.allArray.count + 1) {
//        static NSString * cellId2 = @"cellId2";
//        ZRTuanPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
//        if (cell == nil) {
//            cell = [[ZRTuanPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
//        }
//        ZRUser * user = [ZRUserTool user];
//        [cell.phoneLabel setText:user.phone];
//        return cell;
//    }
    else {
        static NSString * cellId = @"cellId";
        ZRTuanOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ZRTuanOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        ZRShoppingCarDetailModel * model = [self.allArray objectAtIndex:indexPath.section];
        [cell.groupNameLabel setText:model.groupName];
        [cell.groupMoneyLabel setText:[NSString stringWithFormat:@"$%@", model.nowPrice]];
        [cell.groupCountLabel setText:model.num];
        CGFloat money = model.num.intValue * model.nowPrice.floatValue;
        [cell.totalMoneyLabel setText:[NSString stringWithFormat:@"$%.2f", money]];
        return cell;
    }
}
- (void)actionSubmitOrderButton
{
    //NSLog(@"提交订单");
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
