//
//  ZRSectionHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSectionHeaderView.h"

@implementation ZRSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self setViewMasonary];
        [self setBackgroundColor:RGBCOLOR(240, 240, 240)];
    }
    return self;
}
- (void)createView
{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = RGBCOLOR(187, 187, 187);
    [self addSubview:_lineView];
    
    self.pointDetail = [[ZRSectionHeaderDetailView alloc] init];
    [self addSubview:_pointDetail];
    [self.pointDetail.titleLabel setText:@"积分明细"];
    [self.pointDetail.titleLabel setTextColor:R_G_B_16(0xffae02)];
    [self.pointDetail.titleImage setImage:[UIImage imageNamed:@"wdjfhuang"]];
    [self.pointDetail.titleImage sizeToFit];
    
    self.pointExchange = [[ZRSectionHeaderDetailView alloc] init];
    [self addSubview:_pointExchange];
    [self.pointExchange.titleLabel setText:@"兑换记录"];
    [self.pointExchange.titleLabel setTextColor:R_G_B_16(0x555555)];
    [self.pointExchange.titleImage setImage:[UIImage imageNamed:@"dhjlhui"]];
    
    self.pointDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pointDetailButton setBackgroundColor:[UIColor clearColor]];
    self.pointDetailButton.tag = 1000;
    [self.pointDetail addSubview:_pointDetailButton];
    
    self.pointExchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pointExchangeButton setBackgroundColor:[UIColor clearColor]];
    self.pointExchangeButton.tag = 2000;
    [self.pointExchange addSubview:_pointExchangeButton];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.width.mas_equalTo(@1);
    }];
    
    [self.pointDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf.lineView.mas_left).with.offset(0);
    }];
    
    [self.pointExchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineView.mas_right).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
    }];
    
    [self.pointDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.and.bottom.equalTo(weakSelf.pointDetail).with.offset(0);
    }];
    
    [self.pointExchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.and.bottom.equalTo(weakSelf.pointExchange).with.offset(0);
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
