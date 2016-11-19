//
//  ZRStoreupTravalCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStoreupTravalCell.h"

@implementation ZRStoreupTravalCell

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
    self.travalImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_travalImage];
    [self.travalImage setImage:[UIImage imageNamed:@"hanbao"]];
    
    self.travalLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_travalLabel];
    [self.travalLabel setFont:[UIFont systemFontOfSize:14]];
    [self.travalLabel setNumberOfLines:0];
    [self.travalLabel setText:@"北京/天津/沈阳/青岛直飞新加坡6天往返含税机票"];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_moneyLabel];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self.moneyLabel setText:@"$1050/人"];
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
    
    [self.travalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.travalImage.mas_right).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf.travalImage.mas_top).with.offset(2);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.travalLabel);
        make.bottom.equalTo(weakSelf.travalImage.mas_bottom).with.offset(-2);
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
