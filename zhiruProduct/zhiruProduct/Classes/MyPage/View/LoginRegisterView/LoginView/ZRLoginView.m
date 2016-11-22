//
//  ZRLoginView.m
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLoginView.h"

@implementation ZRLoginView


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
    self.label = [[UILabel alloc] init];
    [self addSubview:self.label];
    
    self.textField = [[UITextField alloc] init];
    [self addSubview:self.textField];
    
    WS(weakSelf);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(@40);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label.mas_right).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(5);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
}
- (void)labelText:(NSString *)labelStr labelTextFont:(CGFloat)font textFieldPlaceHolder:(NSString *)textFieldStr textFieldSecureTextEntry:(BOOL)YesOrNo
{
    [self.label setText:labelStr];
    [self.label setFont:[UIFont systemFontOfSize:font]];
    [self.textField setPlaceholder:textFieldStr];
    [self.textField setSecureTextEntry:YesOrNo];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
