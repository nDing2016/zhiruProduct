//
//  ZRQuanTravalCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRQuanTravalCell.h"

@implementation ZRQuanTravalCell

- (void)setmodel
{
    [self.travalImage setImage:[UIImage imageNamed:@"hanbao"]];
    [self.travalAddressLabel setText:@"北京/天津/沈阳/青岛直飞新加坡澳大利亚"];
    [self.travalMoneyLabel setText:@"$2000"];
    [self.timeLabel setText:@"有效期至:2016/12/28"];
    [self.stateLabel setText:@"全部订单"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
