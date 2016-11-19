//
//  ZRMyWalletHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyWalletHeaderView.h"

@implementation ZRMyWalletHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = RGBCOLOR(85, 85, 85);
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    
    self.moneyImage = [[UIImageView alloc] init];
    [self addSubview:_moneyImage];
    [self.moneyImage setImage:[UIImage imageNamed:@"_yuerbeijing"]];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.moneyLabel setText:@"$3000.00"];
    [self.moneyLabel setTextColor:[UIColor whiteColor]];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:25]];
    [self.moneyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.moneyImage addSubview:self.moneyLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setText:@"余额"];
    [self.contentLabel setTextColor:[UIColor whiteColor]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
    [self.moneyImage addSubview:self.contentLabel];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.moneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(weakSelf).with.offset(0);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.moneyImage);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.moneyImage);
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).with.offset(10);
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
