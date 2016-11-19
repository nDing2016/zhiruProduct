//
//  ZRBillContentView.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBillContentView.h"

@implementation ZRBillContentView


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
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleLabel setTextColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self addSubview:_contentLabel];
    [self.contentLabel setTextAlignment:NSTextAlignmentRight];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentLabel setTextColor:RGBCOLOR(187, 187, 187)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.mas_equalTo(weakSelf);
    }];
}
- (void)setTitleLabel:(NSString *)titleText contentLabel:(NSString *)contentText
{
    [self.titleLabel setText:titleText];
    [self.contentLabel setText:contentText];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
