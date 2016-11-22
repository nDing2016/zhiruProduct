//
//  ZRSectionHeaderDetailView.m
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSectionHeaderDetailView.h"

@implementation ZRSectionHeaderDetailView

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
    self.titleImage = [[UIImageView alloc] init];
    [self addSubview:_titleImage];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(37.5 / 375.0 * ScreenWidth);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.titleImage.mas_right).with.offset(20);
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
