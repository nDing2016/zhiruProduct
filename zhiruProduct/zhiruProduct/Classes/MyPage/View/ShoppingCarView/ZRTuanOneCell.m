//
//  ZRTuanOneCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTuanOneCell.h"

@implementation ZRTuanOneCell

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
    /*
     // 团购名称
     @property (nonatomic, strong)UILabel * groupNameLabel;
     // 团购价格
     @property (nonatomic, strong)UILabel * groupMoneyLabel;
     // 数量标题
     @property (nonatomic, strong)UILabel * groupNumLabel;
     // 数量
     @property (nonatomic, strong)UILabel * groupCountLabel;
     // 小计标题
     @property (nonatomic, strong)UILabel * totalLabel;
     // 小计价格
     @property (nonatomic, strong)UILabel * totalMoneyLabel;
     */
    
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView1];
    
    self.groupNameLabel = [[UILabel alloc] init];
    [self.groupNameLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_groupNameLabel];
    [self.groupNameLabel setText:@"双人烤肉套餐"];
    
    self.groupMoneyLabel = [[UILabel alloc] init];
    [self.groupMoneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_groupMoneyLabel];
    [self.groupMoneyLabel setText:@"$110"];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView2];
    
    self.groupNumLabel = [[UILabel alloc] init];
    [self.groupNumLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_groupNumLabel];
    [self.groupNumLabel setText:@"数量"];
    
    self.groupCountLabel = [[UILabel alloc] init];
    [self.groupCountLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_groupCountLabel];
    [self.groupCountLabel setText:@"1"];
    
    self.lineView3 = [[UIView alloc] init];
    [self.lineView3 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView3];
    
    self.totalLabel = [[UILabel alloc] init];
    [self.totalLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_totalLabel];
    [self.totalLabel setText:@"小计"];
    
    self.totalMoneyLabel = [[UILabel alloc] init];
    [self.totalMoneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self.totalMoneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self addSubview:_totalMoneyLabel];
    [self.totalMoneyLabel setText:@"$110"];
    
    self.lineView4 = [[UIView alloc] init];
    [self.lineView4 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView4];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(1);
        make.height.mas_equalTo(@39);
    }];
    [self.groupMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(1);
        make.height.mas_equalTo(@39);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.groupNameLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.groupNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.groupCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.groupNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView3.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf.lineView3.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.totalLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
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
