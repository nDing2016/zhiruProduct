//
//  ZRSelectSexView.m
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectSexView.h"

@implementation ZRSelectSexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_manButton];
    [_manButton setImage:[UIImage imageNamed:@"DUIHAOHUI"] forState:UIControlStateNormal];
    [_manButton setImage:[UIImage imageNamed:@"DUIHAO"] forState:UIControlStateSelected];
    
    self.manLabel = [[UILabel alloc] init];
    [self addSubview:_manLabel];
    [self.manLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.manLabel setText:@"先生"];
    [self.manLabel setFont:[UIFont systemFontOfSize:16]];
    [self.manLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_womanButton];
    [_womanButton setImage:[UIImage imageNamed:@"DUIHAOHUI"] forState:UIControlStateNormal];
    [_womanButton setImage:[UIImage imageNamed:@"DUIHAO"] forState:UIControlStateSelected];
    
    self.womanLabel = [[UILabel alloc] init];
    [self addSubview:_womanLabel];
    [self.womanLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.womanLabel setText:@"女士"];
    [self.womanLabel setFont:[UIFont systemFontOfSize:16]];
    [self.womanLabel setTextAlignment:NSTextAlignmentLeft];

}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(85);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.manButton.mas_right).with.offset(10);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(180);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.womanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.womanButton.mas_right).with.offset(10);
        make.centerY.mas_equalTo(weakSelf);
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
