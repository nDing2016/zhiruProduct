//
//  ZRAddressTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAddressTableViewCell.h"
#import "ZRUserAddressModel.h"
@implementation ZRAddressTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self createContentView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createContentView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    [self.contentView addSubview:_backView];
    
    self.modifyImage = [[UIImageView alloc] init];
    [self.backView addSubview:_modifyImage];
    [self.modifyImage setImage:[UIImage imageNamed:@"bianji"]];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.backView addSubview:_nameLabel];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16]];
    
    self.sexLabel = [[UILabel alloc] init];
    [self.backView addSubview:_sexLabel];
    [self.sexLabel setFont:[UIFont systemFontOfSize:16]];
    
    self.phoneNumberLabel = [[UILabel alloc] init];
    [self.backView addSubview:_phoneNumberLabel];
    [self.phoneNumberLabel setFont:[UIFont systemFontOfSize:16]];

    
    self.addressLabel = [[UILabel alloc] init];
    [self.addressLabel setTextColor:RGBCOLOR(187, 187, 187)];
    [self.backView addSubview:_addressLabel];
    [self.addressLabel setFont:[UIFont systemFontOfSize:16]];
    
    self.lineView = [[UIView alloc] init];
    [self.lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.contentView addSubview:_lineView];
    
    self.backFootView = [[UIView alloc] init];
    [self.contentView addSubview:_backFootView];
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectButton setImage:ZRImage(@"DUIHAOHUI") forState:UIControlStateNormal];
    [self.selectButton setImage:ZRImage(@"DUIHAO") forState:UIControlStateSelected];
    [self.backFootView addSubview:_selectButton];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setText:@"设置为默认地址"];
    [self.contentLabel setTextColor:R_G_B_16(0x555555)];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.backFootView addSubview:self.contentLabel];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    
    [self.modifyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.backView);
        make.right.equalTo(weakSelf.backView).with.offset(-15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).with.offset(15);
        make.top.equalTo(weakSelf.backView).with.offset(9);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.backView).with.offset(9);
    }];
    
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.sexLabel.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.backView).with.offset(9);
    }];
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).with.offset(15);
        make.bottom.equalTo(weakSelf.backView).with.offset(-9);
        make.right.equalTo(weakSelf.backView).with.offset(-10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(69);
        make.height.mas_equalTo(@1);
    }];
    
    [self.backFootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backFootView);
        make.left.equalTo(weakSelf).with.offset(15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backFootView);
        make.left.equalTo(weakSelf.selectButton.mas_right).with.offset(10);
    }];

}
- (void)setModel:(ZRUserAddressModel *)model
{
    _model = model;
    //NSLog(@"%@", _model.name);
    [self.nameLabel setText:_model.name];
    int gender = _model.gender;
    if (gender == 0) {
        [self.sexLabel setText:@"先生"];
    } else if (gender == 1) {
        [self.sexLabel setText:@"女士"];
    }
    [self.phoneNumberLabel setText:_model.phone];
    [self.addressLabel setText:_model.address];
    if (_model.isdefault == 1) {
        self.selectButton.selected = YES;
    } else {
        self.selectButton.selected = NO;
    }
    
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
