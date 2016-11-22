//
//  ZROrderContentView.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderContentView.h"

@implementation ZROrderContentView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.menuLabel = [[UILabel alloc] init];
    [self.menuLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_menuLabel];
    [self.menuLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.partLabel = [[UILabel alloc] init];
    [self.partLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_partLabel];
    [self.partLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.partLabel setTextAlignment:NSTextAlignmentRight];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.partLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(0);
//        make.centerY.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.width.mas_equalTo(@30);
    }];
    
    [self.menuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        //        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.partLabel.mas_left).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
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
