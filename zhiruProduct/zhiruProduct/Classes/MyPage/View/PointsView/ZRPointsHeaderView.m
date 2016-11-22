//
//  ZRPointsHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointsHeaderView.h"

@implementation ZRPointsHeaderView

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
    self.headerImage = [[UIImageView alloc] init];
    [self addSubview:_headerImage];
    [self.headerImage setImage:[UIImage imageNamed:@"wodejifen"]];
//    [self.headerImage setBackgroundColor:[UIColor blackColor]];
//    self.headerImage.layer.masksToBounds = YES;
//    self.headerImage.layer.cornerRadius = 50;
    
    self.pointLabel = [[UILabel alloc] init];
//    [self.pointLabel setText:@"789239"];
    [self.pointLabel setTextColor:R_G_B_16(0xffae02)];
    [self.pointLabel setFont:[UIFont systemFontOfSize:22]];
    [self.headerImage addSubview:_pointLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextColor:R_G_B_16(0xffae02)];
    [self.titleLabel setText:@"我的积分"];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.headerImage addSubview:_titleLabel];
    
    self.sectionHeaderView = [[ZRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 175.0 / 667.0 * ScreenHeight, ScreenWidth, 40)];
    [self addSubview:_sectionHeaderView];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(0);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-40);
    }];
    [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.headerImage);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerImage);
        make.top.equalTo(weakSelf.pointLabel.mas_bottom).with.offset(13);
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
