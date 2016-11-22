//
//  ZRShoppingCarFooterView.m
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarFooterView.h"

@implementation ZRShoppingCarFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectButton];
    [self.selectButton setImage:[UIImage imageNamed:@"daixuan"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.clearingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_clearingButton];
    [self.clearingButton setBackgroundColor:RGBCOLOR(255, 82, 82)];
    [self.clearingButton setTitle:@"结算" forState:UIControlStateNormal];
    [self.clearingButton setTitle:@"删除" forState:UIControlStateSelected];
    [self.clearingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearingButton addTarget:self action:@selector(actionClearingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self addSubview:_moneyLabel];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:18]];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self.moneyLabel setTextAlignment:NSTextAlignmentLeft];
    [self.moneyLabel setText:@"$0.00"];
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.titleLabel setText:@"合计: "];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    [self.lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    [self.clearingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.width.mas_equalTo(@115);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.clearingButton.mas_left).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.width.mas_equalTo(@120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.moneyLabel.mas_left).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
}
- (void)actionButtonClick:(UIButton *)sender
{
    [self.delegate footViewSlelectButton:sender];
}
- (void)actionClearingButton:(UIButton *)sender
{
    [self.delegate footViewClearingButton:sender];
}
- (void)setClearingState:(BOOL)clearingState
{
    _clearingState = clearingState;
    self.clearingButton.selected = _clearingState;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
