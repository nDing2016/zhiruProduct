//
//  ZRRechargeSuccessView.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRechargeSuccessView.h"

@implementation ZRRechargeSuccessView

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
    self.successImage = [[UIImageView alloc] init];
    [self.successImage setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:_successImage];
    
    self.successLabel = [[UILabel alloc] init];
    [self.successLabel setText:@"充值成功"];
    [self.successLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:_successLabel];
    
    self.fangshi = [[ZRSuccessDetailView alloc] initWithFrame:CGRectMake(0, 176, ScreenWidth, 40)];
    [self.fangshi setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_fangshi];
    
    self.jine = [[ZRSuccessDetailView alloc] initWithFrame:CGRectMake(0, _fangshi.frame.origin.y + _fangshi.frame.size.height, ScreenWidth, 40)];
    [self.jine setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_jine];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = RGBCOLOR(187, 187, 187);
    [self.fangshi addSubview:_lineView1];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = RGBCOLOR(187, 187, 187);
    [self.jine addSubview:_lineView2];
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = RGBCOLOR(187, 187, 187);
    [self.jine addSubview:_lineView3];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.successImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(35);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.successImage.mas_bottom).with.offset(10);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@30);
    }];
    
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.fangshi).with.offset(0);
        make.right.equalTo(weakSelf.fangshi).with.offset(0);
        make.top.equalTo(weakSelf.fangshi).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.jine).with.offset(0);
        make.right.equalTo(weakSelf.jine).with.offset(0);
        make.top.equalTo(weakSelf.jine).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.jine).with.offset(0);
        make.right.equalTo(weakSelf.jine).with.offset(0);
        make.top.equalTo(weakSelf.jine.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
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
