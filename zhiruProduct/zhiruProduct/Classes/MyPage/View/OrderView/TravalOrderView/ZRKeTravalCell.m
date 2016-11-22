//
//  ZRKeTravalCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRKeTravalCell.h"

@implementation ZRKeTravalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
        [self setmodel];
    }
    return self;
}
- (void)createView
{
    self.travalImage = [[UIImageView alloc] init];
    [self addSubview:_travalImage];
    
    self.travalAddressLabel = [[UILabel alloc] init];
    [self addSubview:_travalAddressLabel];
    [self.travalAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [self.travalAddressLabel setFont:[UIFont systemFontOfSize:15]];
    
    self.titleMoneyLabel = [[UILabel alloc] init];
    [self addSubview:_titleMoneyLabel];
    [self.titleMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleMoneyLabel setText:@"价格: "];
    
    self.travalMoneyLabel = [[UILabel alloc] init];
    [self addSubview:_travalMoneyLabel];
    [self.travalMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [self.travalMoneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    
    self.timeLabel = [[UILabel alloc] init];
    [self addSubview:_timeLabel];
    [self.timeLabel setFont:[UIFont systemFontOfSize:15]];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.stateLabel = [[UILabel alloc] init];
    [self addSubview:_stateLabel];
    [self.stateLabel setFont:[UIFont systemFontOfSize:15]];
    [self.stateLabel setTextColor:RGBCOLOR(255, 82, 82)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.travalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-15);
        make.width.mas_equalTo(@100);
    }];
    
    [self.travalAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.travalImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.travalImage.mas_top).with.offset(2);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(@23);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.bottom.equalTo(weakSelf.travalImage.mas_bottom).with.offset(-2);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.travalAddressLabel);
        make.bottom.equalTo(weakSelf.travalImage.mas_bottom).with.offset(-2);
        make.right.equalTo(weakSelf.stateLabel.mas_left).with.offset(5);
        make.top.equalTo(weakSelf.stateLabel);
    }];
    
    [self.titleMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.travalAddressLabel);
        make.top.equalTo(weakSelf.travalAddressLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(weakSelf.timeLabel.mas_top).with.offset(-5);
    }];
    
    [self.travalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleMoneyLabel.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.titleMoneyLabel);
        make.bottom.equalTo(weakSelf.titleMoneyLabel);
    }];
}
- (void)setmodel
{
    [self.travalImage setImage:[UIImage imageNamed:@"hanbao"]];
    [self.travalAddressLabel setText:@"北京/天津/沈阳/青岛直飞新加坡澳大利亚"];
    [self.travalMoneyLabel setText:@"$2000"];
    [self.timeLabel setText:@"有效期至:2016/12/28"];
    [self.stateLabel setText:@"待出行"];
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
