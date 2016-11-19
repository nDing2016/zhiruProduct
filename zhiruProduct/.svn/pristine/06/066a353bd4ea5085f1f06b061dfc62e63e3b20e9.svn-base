//
//  ZRAddView.m
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAddView.h"

@implementation ZRAddView
{
    UIImageView * _addImage;
    UILabel * _addLabel;
}
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
    _addLabel = [[UILabel alloc] init];
    [self addSubview:_addLabel];
    [_addLabel setText:@"新增地址"];
    [_addLabel setFont:[UIFont systemFontOfSize:16]];
    _addLabel.textColor = RGBCOLOR(255, 82, 82);
    _addImage = [[UIImageView alloc] init];
    [self addSubview:_addImage];
    [_addImage setImage:[UIImage imageNamed:@"jia"]];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_clearButton];
    [self.clearButton setBackgroundColor:[UIColor clearColor]];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(_addLabel.mas_left).with.offset(-5);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.right.and.bottom.equalTo(weakSelf).with.offset(0);
        
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
