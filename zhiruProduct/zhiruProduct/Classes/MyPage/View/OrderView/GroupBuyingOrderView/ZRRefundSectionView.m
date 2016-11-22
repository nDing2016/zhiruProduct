//
//  ZRRefundSectionView.m
//  zhiruProduct
//
//  Created by pj on 16/9/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRefundSectionView.h"

@implementation ZRRefundSectionView

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
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView1];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setText:@"退款流程"];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_titleLabel];
    
    self.imgView = [[UIImageView alloc] init];
    [self.imgView setImage:[UIImage imageNamed:@"jiantou-you2"]];
    [self addSubview:_imgView];
    
    self.refundLabel = [[UILabel alloc] init];
    [self.refundLabel setText:@"退款帮助"];
    [self.refundLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_refundLabel];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView2];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_clearButton];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.refundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.imgView.mas_left).with.offset(-15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(weakSelf).with.offset(0);
        make.left.equalTo(weakSelf.refundLabel.mas_left);
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
