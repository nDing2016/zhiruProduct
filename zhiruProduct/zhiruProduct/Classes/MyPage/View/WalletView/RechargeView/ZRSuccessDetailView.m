//
//  ZRSuccessDetailView.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSuccessDetailView.h"

@implementation ZRSuccessDetailView

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
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_contentLabel];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
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
