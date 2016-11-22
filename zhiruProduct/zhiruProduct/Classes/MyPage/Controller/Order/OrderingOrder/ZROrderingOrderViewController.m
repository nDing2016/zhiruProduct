//
//  ZROrderingOrderViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingOrderViewController.h"
#import "ZROrderingOrderCell.h"
#import "ZROrderingOrderDetailsController.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRMyOrderViewController.h"
#import "ZROrderingEvaluateController.h"
@interface ZROrderingOrderViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ZROrderingOrderViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_tableView];
        UIView * view = [[UIView alloc] init];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
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
    return cell;
}

#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZROrderingOrderDetailsController *orderDetailsVC = [[ZROrderingOrderDetailsController alloc] init];
    
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    
    [myOrdreVC.navigationController pushViewController:orderDetailsVC animated:YES];
}
// 订餐去评价
- (void)orderingCommentButton:(UIButton *)sender
{
    //NSLog(@"%ld---订餐去评价", (long)sender.tag);
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    
    ZROrderingEvaluateController * orderComment = [[ZROrderingEvaluateController alloc] init];
    [myOrdreVC.navigationController pushViewController:orderComment animated:YES];
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
