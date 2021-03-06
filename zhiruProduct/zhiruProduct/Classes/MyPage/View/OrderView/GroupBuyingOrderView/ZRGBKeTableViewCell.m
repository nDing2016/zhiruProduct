//
//  ZRGBKeTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBKeTableViewCell.h"

@implementation ZRGBKeTableViewCell

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
    self.headerBackView = [[UIView alloc] init];
    [self.contentView addSubview:_headerBackView];
    
    self.businessLabel = [[UILabel alloc] init];
    [self.headerBackView addSubview:_businessLabel];
    [self.businessLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self.businessLabel setTextAlignment:NSTextAlignmentLeft];
    
    
    self.moneyTitleLabel = [[UILabel alloc] init];
    [self.headerBackView addSubview:_moneyTitleLabel];
    [self.moneyTitleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self.moneyTitleLabel setTextAlignment:NSTextAlignmentRight];
    
    
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.headerBackView addSubview:_moneyLabel];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self.moneyLabel setTextAlignment:NSTextAlignmentRight];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    
    
    
    self.rightImage = [[UIImageView alloc] init];
    [self.headerBackView addSubview:_rightImage];
    [self.rightImage setImage:[UIImage imageNamed:@"jiantou-you"]];
    
    self.lineView = [[UIView alloc] init];
    [self.headerBackView addSubview:_lineView];
    self.lineView.backgroundColor = RGBCOLOR(187, 187, 187);
    
    self.footerBackView = [[UIView alloc] init];
    [self.contentView addSubview:_footerBackView];
    
    self.businessImage = [[UIImageView alloc] init];
    [self.footerBackView addSubview:_businessImage];
    [self.businessImage setImage:[UIImage imageNamed:@"hanbao"]];
    
    
    self.groupLabel = [[UILabel alloc] init];
    [self.footerBackView addSubview:_groupLabel];
    [self.groupLabel setFont:[UIFont systemFontOfSize:14]];
    [self.groupLabel setTextAlignment:NSTextAlignmentLeft];
    
//    [self.groupLabel setBackgroundColor:[UIColor yellowColor]];
    
    
    self.groupTitleLabel = [[UILabel alloc] init];
    [self.footerBackView addSubview:_groupTitleLabel];
    [self.groupTitleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [self.groupTitleLabel setTextAlignment:NSTextAlignmentLeft];
//    [self.groupTitleLabel setBackgroundColor:[UIColor yellowColor]];
    
    self.groupMoneyLabel = [[UILabel alloc] init];
    [self.footerBackView addSubview:_groupMoneyLabel];
    [self.groupMoneyLabel setFont:[UIFont systemFontOfSize:14]];
    
    [self.groupMoneyLabel setTextAlignment:NSTextAlignmentLeft];
    [self.groupMoneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
//    [self.groupMoneyLabel setBackgroundColor:[UIColor yellowColor]];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.footerBackView addSubview:_timeLabel];
    [self.timeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    
//    [self.timeLabel setBackgroundColor:[UIColor yellowColor]];
    
    self.stateLabel = [[UILabel alloc] init];
    [self.footerBackView addSubview:_stateLabel];
    [self.stateLabel setFont:[UIFont systemFontOfSize:14]];
    
    [self.stateLabel setTextAlignment:NSTextAlignmentRight];
    [self.stateLabel setTextColor:RGBCOLOR(255, 82, 82)];
//    [self.stateLabel setBackgroundColor:[UIColor yellowColor]];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = RGBCOLOR(255, 82, 82);
    [self.button setTitle:@"待评价" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 3;
    [self.button addTarget:self action:@selector(actionOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerBackView addSubview:self.button];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.headerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@35);
    }];
    
    [self.businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerBackView).with.offset(15);
        make.centerY.equalTo(weakSelf.headerBackView);
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.headerBackView).with.offset(-15);
        make.centerY.equalTo(weakSelf.headerBackView);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightImage.mas_left).with.offset(-5);
        make.centerY.equalTo(weakSelf.headerBackView);
    }];
    
    [self.moneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.moneyLabel.mas_left).with.offset(-2);
        make.centerY.equalTo(weakSelf.headerBackView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerBackView).with.offset(0);
        make.right.equalTo(weakSelf.headerBackView).with.offset(0);
        make.bottom.equalTo(weakSelf.headerBackView).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.footerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.headerBackView.mas_bottom).with.offset(0);
    }];
    
    [self.businessImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.footerBackView).with.offset(15);
        make.top.equalTo(weakSelf.footerBackView).with.offset(15);
        make.bottom.equalTo(weakSelf.footerBackView).with.offset(-15);
    }];
    
    [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.businessImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.businessImage).with.offset(2);
        make.height.mas_equalTo(@23);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupLabel);
        make.bottom.equalTo(weakSelf.businessImage).with.offset(-2);
        make.height.mas_equalTo(@23);
    }];
    
    [self.groupTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupLabel);
        make.top.equalTo(weakSelf.groupLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(weakSelf.timeLabel.mas_top).with.offset(-5);
    }];
    
    [self.groupMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupTitleLabel.mas_right).with.offset(2);
        make.top.equalTo(weakSelf.groupTitleLabel);
        make.bottom.equalTo(weakSelf.groupTitleLabel);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.footerBackView).with.offset(-15);
        make.top.equalTo(weakSelf.timeLabel);
        make.bottom.equalTo(weakSelf.timeLabel);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.footerBackView).with.offset(-15);
        make.top.equalTo(weakSelf.businessImage);
        make.width.mas_equalTo(@75);
    }];
}
- (void)setmodel
{
    [self.businessLabel setText:@"烤肉饭(豫珑城店)"];
    [self.moneyTitleLabel setText:@"实付:"];
    [self.moneyLabel setText:@"$200"];
    [self.groupLabel setText:@"双人烤肉套餐"];
    [self.groupTitleLabel setText:@"价格:"];
    [self.groupMoneyLabel setText:@"$200"];
    [self.timeLabel setText:@"有效期至:2016/12/28"];
    [self.stateLabel setText:@"未使用"];
    [self.button setHidden:YES];
}
- (void)actionOrderButton:(UIButton *)sender
{
    //NSLog(@"可使用");
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
