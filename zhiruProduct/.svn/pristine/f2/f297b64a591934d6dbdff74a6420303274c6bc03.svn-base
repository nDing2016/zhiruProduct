//
//  ZRSearchView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSearchView.h"

@interface ZRSearchView ()


@end

@implementation ZRSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *textBg = [[UIView alloc] initWithFrame:frame];
        
        [self addSubview:textBg];
        
        _textBg = textBg;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    _textBg.backgroundColor = [UIColor clearColor];
    _textBg.layer.cornerRadius = 14;
    _textBg.layer.masksToBounds = YES;
    _textBg.layer.borderWidth = 0.7;
    _textBg.layer.borderColor = [UIColor grayColor].CGColor;
    NSArray * subViewArr = _textBg.subviews;
    for (UIView * subView in subViewArr) {
        [subView removeFromSuperview];
    }

    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo-1"]];
    [_textBg addSubview:iconView];
    WS(ws)
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.textBg);
        make.left.equalTo(ws.textBg.mas_left).with.offset(7 );
        make.width.mas_equalTo(16 );
        make.height.mas_equalTo(16 );
        
    }];

    
    UITextField * searchText = [[UITextField alloc] init];
    searchText.placeholder = @"输入商家、商品名称" ;
    searchText.font = [UIFont systemFontOfSize:14];
    searchText.textColor = [UIColor grayColor];
    
    [_textBg addSubview:searchText];
    
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconView.mas_right).offset(4 );
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
    }];
}

//点击回调
- (void)pushSearchView{
    if (self.clickSearchView) {
        self.clickSearchView();
    }
}
@end
