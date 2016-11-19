//
//  ZRNeedCommentOrderingController.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNeedCommentOrderingController.h"
#import "ZRNeedCommentOrderingCell.h"

#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRNeedCommentRootController.h"
#import "ZROrderingEvaluateController.h"
@interface ZRNeedCommentOrderingController ()

@end

@implementation ZRNeedCommentOrderingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"needCommentGroup";
    ZRNeedCommentOrderingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRNeedCommentOrderingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(actionOrderingCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)actionOrderingCommentButton:(UIButton *)sender
{
    ZROrderingEvaluateController * orderComment = [[ZROrderingEvaluateController alloc] init];
//    orderComment.businessId
    
    ZRTabBarViewController * tabBar = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController * nav = tabBar.viewControllers[2];
    ZRNeedCommentRootController * commentRootVC = nav.viewControllers[1];
    
    [commentRootVC.navigationController pushViewController:orderComment animated:YES];
    
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
