//
//  ZRTuanTotalCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTuanTotalCell.h"

@implementation ZRTuanTotalCell

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
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView1];
    
    self.totalLabel = [[UILabel alloc] init];
    [self.totalLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_totalLabel];
    [self.totalLabel setText:@"合计"];
    
    self.totalMoneyLabel = [[UILabel alloc] init];
    [self.totalMoneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self.totalMoneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self addSubview:_totalMoneyLabel];
    [self.totalMoneyLabel setText:@"$320"];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView2];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
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
