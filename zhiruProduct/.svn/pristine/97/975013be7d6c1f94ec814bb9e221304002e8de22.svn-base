//
//  ZRTradingTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTradingTableViewCell.h"

@implementation ZRTradingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.dayLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_dayLabel];
    [self.dayLabel setText:@"昨天"];
    [self.dayLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.dayLabel setFont:[UIFont systemFontOfSize:14]];
    [self.dayLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    [self.timeLabel setText:@"20:24"];
    [self.timeLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.Image = [[UIImageView alloc] init];
    [self.contentView addSubview:_Image];
    self.Image.backgroundColor = [UIColor orangeColor];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_moneyLabel];
    [self.moneyLabel setText:@"+$200.00"];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self.moneyLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.sourceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_sourceLabel];
    [self.sourceLabel setText:@"Paypal充值"];
    [self.sourceLabel setFont:[UIFont systemFontOfSize:14]];
    [self.sourceLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.stateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_stateLabel];
    [self.stateLabel setText:@"交易成功"];
    [self.stateLabel setTextAlignment:NSTextAlignmentRight];
    [self.stateLabel setFont:[UIFont systemFontOfSize:14]];
}
- (void)setViewMasonary
{
    CGFloat top = 5.0 + 3.0;
    CGFloat left = 15.0;
    CGFloat right = -15.0;
    CGFloat bottom = -5.0 - 3.0;
    WS(weakSelf);
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(left);
        make.top.equalTo(weakSelf).with.offset(top);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(left);
        make.bottom.equalTo(weakSelf).with.offset(bottom);
    }];
    [self.Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(70);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(40.0 / 375.0 * ScreenWidth, 40.0 / 375.0 * ScreenWidth));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.Image.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.dayLabel);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.moneyLabel);
        make.bottom.equalTo(weakSelf.timeLabel);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dayLabel);
        make.right.equalTo(weakSelf).with.offset(right);
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
