//
//  ZRGBQuanTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBQuanTableViewCell.h"

@implementation ZRGBQuanTableViewCell


- (void)setmodel
{
    [self.businessLabel setText:@"烤肉饭(豫珑城店)"];
    [self.moneyTitleLabel setText:@"实付:"];
    [self.moneyLabel setText:@"$200"];
    [self.groupLabel setText:@"双人烤肉套餐"];
    [self.groupTitleLabel setText:@"价格:"];
    [self.groupMoneyLabel setText:@"$200"];
    [self.timeLabel setText:@"有效期至:2016/12/28"];
    [self.stateLabel setText:@"全部订单"];
    [self.button setHidden:NO];
    [self.button setTitle:@"全部" forState:UIControlStateNormal];
}
- (void)actionOrderButton:(UIButton *)sender
{
    //NSLog(@"%@", sender.titleLabel.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
