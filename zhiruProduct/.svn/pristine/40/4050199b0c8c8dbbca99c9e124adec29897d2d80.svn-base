//
//  ZRUserAgreementView.m
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

// 协议
#import "ZRUserAgreementView.h"
#import "ZRStringWithLabel.h"
@implementation ZRUserAgreementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createContentView];
    }
    return self;
}
- (void)createContentView
{
    CGFloat height = self.frame.size.height;
    //NSLog(@"! %f", height);
    self.stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_stateButton];
    
    WS(weakSelf);
    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(height, height));
    }];
    [self.stateButton setImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];
    [self.stateButton setImage:[UIImage imageNamed:@"hougou]"] forState:UIControlStateSelected];
    
    
    CGFloat labelWith = [ZRStringWithLabel returanWidthWithText:@"我已阅读并同意XX" height:height font:[UIFont systemFontOfSize:14.0]];
    self.label = [[UILabel alloc] init];
    [self.label setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_label];

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.stateButton.mas_right).with.offset(5);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(labelWith + 3);
    }];
    [self.label setText:@"我已阅读并同嘿唐"];
    [self.label setFont:[UIFont systemFontOfSize:14.0]];
    
    self.agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.agreementButton];
    CGFloat buttonWidth = [ZRStringWithLabel returanWidthWithText:@"<<用户使用协议>>" height:height font:[UIFont systemFontOfSize:14.0]];
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label.mas_right).with.offset(1);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(buttonWidth + 3);
    }];
    [self.agreementButton setTitle:@"<<用户使用协议>>" forState:UIControlStateNormal];
    [self.agreementButton setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    [self.agreementButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
