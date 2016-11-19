//
//  ZRHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHeaderView.h"

@implementation ZRHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setArray:(NSArray *)array
{
    _array = array;
    
    CGFloat labelHeight = self.frame.size.height;
    CGFloat labelWidth = self.frame.size.width * 1.0 / _array.count;
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, labelHeight)];
    [self.backView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_backView];
    
    for (int i = 0; i < _array.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(labelWidth * i, 0, labelWidth, labelHeight)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [button setTitle:[_array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [self.backView addSubview:button];
        if (i == 0) {
            [button setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
        }
    }
    self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight - 4, labelWidth, 4)];
    [self.viewLabel setBackgroundColor:RGBCOLOR(255, 82, 82)];
    [self addSubview:_viewLabel];
}
- (void)actionSelectButton:(UIButton *)sender
{
    [self.delegate selectSender:sender];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
