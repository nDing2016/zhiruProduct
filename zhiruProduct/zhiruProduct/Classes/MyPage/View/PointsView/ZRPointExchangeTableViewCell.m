//
//  ZRPointExchangeTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointExchangeTableViewCell.h"

@implementation ZRPointExchangeTableViewCell

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
    self.merchandiseLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_merchandiseLabel];
    [self.merchandiseLabel setFont:[UIFont systemFontOfSize:15]];
    [self.merchandiseLabel setTextAlignment:NSTextAlignmentLeft];
    [self.merchandiseLabel setTextColor:R_G_B_16(0x555555)];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.timeLabel setTextColor:R_G_B_16(0x9e9e9e)];
    
    self.exchangePoint = [[UILabel alloc] init];
    [self.contentView addSubview:_exchangePoint];
    [self.exchangePoint setFont:[UIFont systemFontOfSize:16]];
    [self.exchangePoint setTextAlignment:NSTextAlignmentLeft];
    [self.exchangePoint setTextColor:R_G_B_16(0xff5252)];
    
    self.pointImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_pointImage];
    [self.pointImage setImage:ZRImage(@"jifenyue-81")];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.merchandiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(7);
        make.right.equalTo(weakSelf.pointImage.mas_left).with.offset(-15);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-7);
    }];
    [self.pointImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-50);
        make.top.equalTo(weakSelf).with.offset(7);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.exchangePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pointImage.mas_right).with.offset(5);
        make.top.equalTo(weakSelf).with.offset(7);
    }];
}
- (void)setModel:(ZRExchangeDetailModel *)model
{
    _model = model;
    [self.merchandiseLabel setText:_model.channel];
    [self.timeLabel setText:_model.creatDate];
    [self.exchangePoint setText:_model.points];
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
