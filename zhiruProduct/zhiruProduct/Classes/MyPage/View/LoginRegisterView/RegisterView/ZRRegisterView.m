//
//  ZRRegisterView.m
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

// label + textfield
#import "ZRRegisterView.h"

@implementation ZRRegisterView


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
    [self.label setTextColor:RGBCOLOR(85, 85, 85)];
    [self addSubview:self.label];
    
    self.textField = [[UITextField alloc] init];
    [self.textField setTextColor:RGBCOLOR(85, 85, 85)];
    [self addSubview:self.textField];
//    [self.textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    WS(weakSelf);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(@65);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label.mas_right).with.offset(6);
        make.top.equalTo(weakSelf).with.offset(5);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
}

-(void)setIsPhone:(BOOL)isPhone{
    _isPhone = isPhone;
     [self.textField setKeyboardType:UIKeyboardTypePhonePad];
}

- (void)labelText:(NSString *)labelStr labelTextFont:(CGFloat)font textFieldPlaceHolder:(NSString *)textFieldStr textFieldSecureTextEntry:(BOOL)YesOrNo
{
    [self.label setTextAlignment:NSTextAlignmentLeft];
    [self.label setText:labelStr];
    [self.label setFont:[UIFont systemFontOfSize:font]];
    [self.textField setPlaceholder:textFieldStr];
    [self.textField setSecureTextEntry:YesOrNo];
   
}
- (void)updateMasonary:(NSString *)text labelFont:(CGFloat)font
{
    [self.label setText:text];
    [self.label setFont:[UIFont systemFontOfSize:font]];
    WS(weakSelf);
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(@80);
    }];
    
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label.mas_right).with.offset(6);
        make.top.equalTo(weakSelf).with.offset(5);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.right.equalTo(weakSelf).with.offset(-15);
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
