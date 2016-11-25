//
//  ZRLunchOneCell.m
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchOneCell.h"

@implementation ZRLunchOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:RGBCOLOR(240, 240, 240)];
    }
    return self;
}
- (void)createView
{
    self.backView = [[UIView alloc] init];
    [self.backView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_backView];
    
    self.imgView = [[UIImageView alloc] init];
    [self.imgView setImage:[UIImage imageNamed:@"wucan"]];
    [self.backView addSubview:_imgView];
    
    self.orderState = [[UILabel alloc] init];
    [self.orderState setFont:[UIFont systemFontOfSize:16]];
    [self.orderState setTextColor:RGBCOLOR(85, 85, 85)];
    [self.backView addSubview:_orderState];
    [self.orderState setText:@"订单已完成"];
    
    self.orderTime = [[UILabel alloc] init];
    [self.orderTime setFont:[UIFont systemFontOfSize:14]];
    [self.orderTime setTextColor:R_G_B_16(0x9c9c9c)];
    [self.backView addSubview:_orderTime];
    [self.orderTime setText:@"2016-06-27 08:06"];
    [self.orderTime setTextColor:RGBCOLOR(85, 85, 85)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.right.equalTo(weakSelf.contentView).with.offset(0);
        make.height.mas_equalTo(@110);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).with.offset(15);
        make.centerY.equalTo(weakSelf.backView);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    [self.orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView.mas_right).with.offset(15);
        make.top.equalTo(weakSelf.backView).with.offset(15);
        make.height.mas_equalTo(@25);
    }];
    [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView.mas_right).with.offset(15);
        make.bottom.equalTo(weakSelf.backView).with.offset(-15);
        make.height.mas_equalTo(@25);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end