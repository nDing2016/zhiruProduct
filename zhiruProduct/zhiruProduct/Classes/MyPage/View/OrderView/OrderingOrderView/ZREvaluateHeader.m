//
//  ZREvaluateHeader.m
//  zhiruProduct
//
//  Created by pj on 16/10/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZREvaluateHeader.h"

@implementation ZREvaluateHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.menuBackView = [[UIView alloc] init];
    [self addSubview:_menuBackView];
    
    self.menuTitleLabel = [[UILabel alloc] init];
    [self.menuBackView addSubview:_menuTitleLabel];
    [self.menuTitleLabel setText:@"商品订单"];
    [self.menuTitleLabel setFont:[UIFont systemFontOfSize:17]];
    
    self.menuContentLabel = [[UILabel alloc] init];
    [self.menuBackView addSubview:_menuContentLabel];
    [self.menuContentLabel setText:@"白菜肉水饺+牛肉辣椒水饺+水晶葡萄"];
    [self.menuContentLabel setFont:[UIFont systemFontOfSize:14]];
    [self.menuContentLabel setTextColor:RGBCOLOR(136, 136, 136)];
    
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.menuBackView addSubview:_lineView1];
    
    self.starBackView = [[UIView alloc] init];
    [self addSubview:_starBackView];
    
    self.starTitleLabel = [[UILabel alloc] init];
    [self.starBackView addSubview:_starTitleLabel];
    [self.starTitleLabel setText:@"总体"];
    [self.starTitleLabel setFont:[UIFont systemFontOfSize:18]];
    
    self.lineView2 = [[UILabel alloc] init];
    [self.starBackView addSubview:_lineView2];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    
    self.pointBackView = [[UIView alloc] init];
    [self addSubview:_pointBackView];
    
    self.tasteTitleLabel = [[UILabel alloc] init];
    [self.pointBackView addSubview:_tasteTitleLabel];
    [self.tasteTitleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.tasteTitleLabel setText:@"口味"];
    
    self.serveTitleLabel = [[UILabel alloc] init];
    [self.pointBackView addSubview:_serveTitleLabel];
    [self.serveTitleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.serveTitleLabel setText:@"服务"];
    
    self.lineView3 = [[UIView alloc] init];
    [self addSubview:_lineView3];
    [self.lineView3 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    
    self.textView = [[UITextView alloc] init];
    [self.textView setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_textView];
    
    self.textPlaceLabel = [[UILabel alloc] init];
    [self.textView addSubview:_textPlaceLabel];
    [self.textPlaceLabel setText:@"亲, 菜品的口味如何, 服务满意吗?"];
    [self.textPlaceLabel setFont:[UIFont systemFontOfSize:15]];
    [self.textPlaceLabel setTextColor:RGBCOLOR(136, 136, 136)];
    
    self.textFootLabel = [[UILabel alloc] init];
    [self.textView addSubview:_textFootLabel];
    [self.textFootLabel setText:@"最少输入15个字"];
    [self.textFootLabel setFont:[UIFont systemFontOfSize:15]];
    [self.textFootLabel setTextColor:RGBCOLOR(136, 136, 136)];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.menuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@60);
    }];
    [self.menuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.menuBackView.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.menuBackView.mas_top).with.offset(0);
        make.height.mas_equalTo(@30);
    }];
    [self.menuContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.menuBackView.mas_left).with.offset(15);
        make.bottom.equalTo(weakSelf.menuBackView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@30);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf.menuBackView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.starBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@80);
    }];
    
    [self.starTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.starBackView.mas_left).with.offset(15);
        make.centerY.equalTo(weakSelf.starBackView);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.starBackView).with.offset(0);
        make.bottom.equalTo(weakSelf.starBackView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.pointBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@80);
    }];
    
    [self.tasteTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pointBackView).with.offset(15);
        make.top.equalTo(weakSelf.pointBackView).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.serveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pointBackView).with.offset(15);
        make.top.equalTo(weakSelf.pointBackView).with.offset(40);
        make.height.mas_equalTo(@40);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.pointBackView).with.offset(0);
        make.bottom.equalTo(weakSelf.pointBackView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.top.equalTo(weakSelf.lineView3.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@185);
    }];
    
    [self.textPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView).with.offset(5);
        make.left.equalTo(weakSelf.textView).with.offset(0);
    }];
    
    
    [self.textFootLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).with.offset(-5);
//        make.left.equalTo(weakSelf.textView).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(-10);
        
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