//
//  ZRNeedCommentGroupCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNeedCommentGroupCell.h"

@implementation ZRNeedCommentGroupCell

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
    self.groupImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_groupImage];
    [self.groupImage setImage:[UIImage imageNamed:@"hanbao"]];
    
    self.groupLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_groupLabel];
    [self.groupLabel setFont:[UIFont systemFontOfSize:15]];
    [self.groupLabel setText:@"烤肉饭(豫珑城店)"];
    
    self.taocanLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_taocanLabel];
    [self.taocanLabel setFont:[UIFont systemFontOfSize:15]];
    [self.taocanLabel setText:@"双人烤肉套餐"];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_moneyLabel];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self.moneyLabel setText:@"$200"];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setBackgroundColor:RGBCOLOR(255, 82, 82)];
    [self.button setTitle:@"评一下" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 4;
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_button];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.groupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-15);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.groupImage.mas_top).with.offset(2);
        make.left.equalTo(weakSelf.groupImage.mas_right).with.offset(10);
        make.height.mas_equalTo(@23);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.groupImage.mas_bottom).with.offset(-2);
        make.left.equalTo(weakSelf.groupLabel);
        make.height.mas_equalTo(@23);
    }];
    
    [self.taocanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupLabel);
        make.top.equalTo(weakSelf.groupLabel.mas_bottom).with.offset(3);
        make.bottom.equalTo(weakSelf.moneyLabel.mas_top).with.offset(-3);
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
