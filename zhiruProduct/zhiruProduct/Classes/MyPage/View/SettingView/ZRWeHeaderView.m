//
//  ZRWeHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWeHeaderView.h"

@implementation ZRWeHeaderView


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
    self.appImage = [[UIImageView alloc] init];
    [self addSubview:_appImage];
    [self.appImage setImage:[UIImage imageNamed:@"APP-icon"]];
    self.appImage.layer.masksToBounds = YES;
    self.appImage.layer.cornerRadius = 8.f;
    
    self.versionNumber = [[UILabel alloc] init];
    [self addSubview:_versionNumber];
    [self.versionNumber setFont:[UIFont systemFontOfSize:16]];
    [self.versionNumber setText:@"V1.0.0"];
    [self.versionNumber setTextColor:RGBCOLOR(85, 85, 85)];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [self.versionNumber setText:[NSString stringWithFormat:@"V%@", currentVersion]];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.appImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(30);
//        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [self.versionNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.appImage.mas_bottom).with.offset(15);
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
