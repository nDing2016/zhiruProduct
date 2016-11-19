//
//  ZRProblemZeroView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemZeroView.h"

@implementation ZRProblemZeroView

- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    CGSize size1 = [self drawWithStr:@"1. 如何更改绑定的手机号" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"点击我的→个人信息→绑定手机号→修改手机号\n即可修改目前已绑定的手机号。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 账号名和密码忘记了怎么办？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"可使用登录页面下方的“忘记密码”字样，进入“找回密码”流程：\n输入绑定手机号→获取验证码→修改密码（输入新密码）→重新登录" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 为什么我的账号无法登陆？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    CGSize size6 = [self drawWithStr:@"嘿唐账户无法登陆有以下几种情况：\n账户名和密码不匹配，请注意填写的账户名和密码是否正确；\n高风险账号（如账号被盗用等）请点击“忘记密码”，通过验证手机号找回。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
    CGFloat height3 = 10;
    
    CGSize size7 = [self drawWithStr:@"4. VIP会员身份是什么？如何成为会员？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + height1 + height2 + height3)];
    [self drawWithStr:@"点击我的→我的钱包→成为会员，或点击我的→个人信息→会员身份，即可获取关于会员身份的详细说明。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
