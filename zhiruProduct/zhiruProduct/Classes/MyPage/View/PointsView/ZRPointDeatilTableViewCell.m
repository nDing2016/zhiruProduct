//
//  ZRPointDeatilTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDeatilTableViewCell.h"

@implementation ZRPointDeatilTableViewCell


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
    self.pointType = [[UILabel alloc] init];
    [self.contentView addSubview:_pointType];
    [self.pointType setTextAlignment:NSTextAlignmentLeft];
    [self.pointType setFont:[UIFont systemFontOfSize:15]];
    [self.pointType setTextColor:R_G_B_16(0x555555)];
    
    self.pointSource = [[UILabel alloc] init];
    [self.contentView addSubview:_pointSource];
    [self.pointSource setTextColor:R_G_B_16(0x9e9e9e)];
    [self.pointSource setFont:[UIFont systemFontOfSize:13]];
    [self.pointSource setTextAlignment:NSTextAlignmentLeft];
    
    self.pointLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_pointLabel];
    [self.pointLabel setTextColor:R_G_B_16(0xff5252)];
    [self.pointLabel setFont:[UIFont systemFontOfSize:15]];
    [self.pointLabel setTextAlignment:NSTextAlignmentRight];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    [self.timeLabel setTextColor:R_G_B_16(0x555555)];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.timeLabel setTextAlignment:NSTextAlignmentRight];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.pointType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(7);
    }];
    [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(7);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.bottom.equalTo(weakSelf).with.offset(-7);
    }];
    [self.pointSource mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-7);
        make.right.equalTo(weakSelf.timeLabel.mas_left).with.offset(-5);
    }];
}
- (void)setModel:(ZRPointsDeatilModel *)model
{
    _model = model;
    [self.pointType setText:model.typeName];
    [self.pointSource setText:model.channel];
    [self.pointLabel setText:model.points];
    [self.timeLabel setText:model.creatDate];
    
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
