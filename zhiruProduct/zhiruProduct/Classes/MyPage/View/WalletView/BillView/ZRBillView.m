//
//  ZRBillView.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBillView.h"
//#import "ZRBillContentView.h"
@implementation ZRBillView

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
    self.Image = [[UIImageView alloc] init];
    [self addSubview:_Image];
    [self.Image setBackgroundColor:[UIColor yellowColor]];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [self.titleLabel setText:@"烤肉饭"];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:18]];
    [self.moneyLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_moneyLabel];
    [self.moneyLabel setText:@"-$200.00"];
    
    self.billState = [[UILabel alloc] init];
    [self addSubview:_billState];
    [self.billState setText:@"双人烤肉套餐退款"];
    [self.billState setFont:[UIFont systemFontOfSize:14.0]];
    [self.billState setTextColor:RGBCOLOR(85, 85, 85)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(120.0 / 375.0 * ScreenWidth);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.Image.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.Image);
        make.height.equalTo(weakSelf.Image);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.Image.mas_bottom).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@40);
    }];
    [self.billState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@25);
    }];
    
    self.manner = [[ZRBillContentView alloc] initWithFrame:CGRectMake(0, 195 - 64, ScreenWidth, 25)];
    [self addSubview:_manner];
//    [self.manner setBackgroundColor:[UIColor orangeColor]];
    
    self.explain = [[ZRBillContentView alloc] initWithFrame:CGRectMake(0, _manner.frame.origin.y + _manner.frame.size.height + 10, ScreenWidth, 25)];
    [self addSubview:_explain];
//    [self.explain setBackgroundColor:[UIColor purpleColor]];
    
    self.date = [[ZRBillContentView alloc] initWithFrame:CGRectMake(0, _explain.frame.origin.y + _explain.frame.size.height + 10, ScreenWidth, 25)];
    [self addSubview:_date];
//    [self.date setBackgroundColor:[UIColor greenColor]];
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
