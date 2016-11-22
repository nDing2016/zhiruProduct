//
//  ZRGBYiTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBYiTableViewCell.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRMyOrderViewController.h"
#import "ZRPostCommentController.h"
@implementation ZRGBYiTableViewCell


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self createButton];
//        [self setButtonMasonary];
//    }
//    return self;
//}
//- (void)createButton
//{
//    
//    
//    [self.stateLabel setText:@"已使用"];
//}
//- (void)setButtonMasonary
//{
//    
//    
//}
- (void)setmodel
{
    [self.businessLabel setText:@"烤肉饭(豫珑城店)"];
    [self.moneyTitleLabel setText:@"实付:"];
    [self.moneyLabel setText:@"$200"];
    [self.groupLabel setText:@"双人烤肉套餐"];
    [self.groupTitleLabel setText:@"价格:"];
    [self.groupMoneyLabel setText:@"$200"];
    [self.timeLabel setText:@"有效期至:2016/12/28"];
    [self.stateLabel setText:@"待评价"];
    [self.button setHidden:NO];
    [self.button setTitle:@"去评价" forState:UIControlStateNormal];
}
- (void)actionOrderButton:(UIButton *)sender
{
    //NSLog(@"去评价");
    
    ZRPostCommentController * pCommentVC = [[ZRPostCommentController alloc]  init];
    pCommentVC.title = @"发表评论";
//    pCommentVC.businessId = _businessId;
    pCommentVC.commentType = @"1";
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    
    [myOrdreVC.navigationController pushViewController:pCommentVC animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
