//
//  ZRRefundHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/9/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRefundHeaderView.h"

@implementation ZRRefundHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.backView = [[UIView alloc] init];
    [self.backView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_backView];
    
    self.groupLabel = [[UILabel alloc] init];
    [self.groupLabel setText:@"团购券"];
    [self.groupLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.backView addSubview:_groupLabel];
    
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.backView addSubview:_lineView1];
    
    self.groupNumberLabel = [[UILabel alloc] init];
    [self.groupNumberLabel setText:@"团购码: 9553 5827 9812"];
    [self.groupNumberLabel setFont:[UIFont systemFontOfSize:16]];
    [self.backView addSubview:_groupNumberLabel];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.backView addSubview:_lineView2];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.moneyLabel setText:@"价格: $200.00"];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:16]];
    [self.backView addSubview:_moneyLabel];
    
    self.lineView3 = [[UIView alloc] init];
    [self.lineView3 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.backView addSubview:_lineView3];
    
    
    
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@120);
    }];
    
    [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.groupLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.groupNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.groupNumberLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
