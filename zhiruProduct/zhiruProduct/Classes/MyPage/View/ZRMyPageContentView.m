//
//  ZRMyPageContentView.m
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyPageContentView.h"

@implementation ZRMyPageContentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createContentView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createContentView
{
    self.img = [[UIImageView alloc] init];
    self.contentLabel = [[UILabel alloc] init];

    [self addSubview:self.img];
    [self addSubview:self.contentLabel];
    
    //[self.img setImage:[UIImage imageNamed:@"WODEQIANBAO"]];
    [self.contentLabel setText:@"我的钱包"];
    [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.contentLabel setTextColor:R_G_B_16(0x555555)];

    self.contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.contentButton];
    [self.contentButton setBackgroundColor:[UIColor clearColor]];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(25.0 / 667.0 * ScreenHeight, 25.0 / 667.0 * ScreenHeight));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_bottom).with.offset(9);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(-0);
        make.bottom.equalTo(weakSelf).with.offset(-5);
    }];
    
    
    
    
    [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(0);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(-0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
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
