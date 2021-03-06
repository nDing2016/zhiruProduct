//
//  ZRPointView.m
//  zhiruProduct
//
//  Created by pj on 16/12/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointView.h"

@implementation ZRPointView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self setViewMasonary];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)createView
{
    self.lineView = [[UIView alloc] init];
    [self.lineView setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self addSubview:_lineView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_contentLabel];
    [self.contentLabel setTextColor:RGBCOLOR(85, 85, 85)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(90, 40));
        //        make.right.equalTo(weakSelf.contentLabel.mas_left).with.offset(-10);
        //        make.height.mas_equalTo(@40);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(8);
        make.top.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.height.mas_equalTo(@40);
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
