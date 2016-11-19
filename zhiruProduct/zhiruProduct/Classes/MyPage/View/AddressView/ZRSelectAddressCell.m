//
//  ZRSelectAddressCell.m
//  zhiruProduct
//
//  Created by pj on 16/10/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectAddressCell.h"

@implementation ZRSelectAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"daixuan"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(actionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    [self.nameLabel setText:@"朴健"];
    
    self.genderLabel = [[UILabel alloc] init];
    [self.genderLabel setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_genderLabel];
    [self.genderLabel setText:@"先生"];
    
    self.phoneLabel = [[UILabel alloc] init];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_phoneLabel];
    [self.phoneLabel setText:@"18803820931"];
    
    
    self.addressLabel = [[UILabel alloc] init];
    [self.addressLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_addressLabel];
    [self.addressLabel setTextColor:R_G_B_16(0x9c9c9c)];
    [self.addressLabel setText:@"辽宁省沈阳市沈河区西滨河路62甲号"];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(50);
        make.top.equalTo(weakSelf.contentView).with.offset(5);
        make.height.mas_equalTo(@35);
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.contentView).with.offset(5);
        make.height.mas_equalTo(@35);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.genderLabel.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.contentView).with.offset(5);
        make.height.mas_equalTo(@35);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-5);
        make.height.mas_equalTo(@35);
    }];
}
- (void)setModel:(ZRUserAddressModel *)model
{
    _model = model;
    [self.nameLabel setText:_model.name];
    if (_model.gender == 0) {
        [self.genderLabel setText:@"先生"];
    } else {
        [self.genderLabel setText:@"女士"];
    }
    [self.phoneLabel setText:_model.phone];
    [self.addressLabel setText:_model.address];
    self.selectBtn.selected = _model.state;
}
- (void)actionSelectBtn:(UIButton *)sender
{
    [self.delegate getSelectButtonState:sender];
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
