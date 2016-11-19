//
//  ZRWalletRuleView.m
//  zhiruProduct
//
//  Created by pj on 16/9/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWalletRuleView.h"

@implementation ZRWalletRuleView


- (void)drawRect:(CGRect)rect
{
    CGFloat pointY = 15;
    CGSize size1 = [self drawWithStr:@"钱包是什么？" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"嘿唐钱包是指用户在嘿唐App平台上的虚拟现金账户，支持在线支付、退款、提现、设置支付密码功能，不支持转账功能。钱包余额是指用户在嘿唐App平台支付订单时，可用于抵付现金的金额。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    CGSize size3 = [self drawWithStr:@"钱包余额从哪儿来？" Font:[UIFont boldSystemFontOfSize:16]  Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height)];
    CGSize size4 = [self drawWithStr:@"1. 购买嘿唐App会员资格时，会赠送可抵现的金额，不同等级的会员获赠的余额不同。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height)];
    CGSize size5 = [self drawWithStr:@"2. 在嘿唐平台取消已支付的订单，并发生退款后，款项将自动退回嘿唐钱包余额。（通过Paypal、银行卡、微信、支付宝、钱包余额等支付方式支付的订单，退款后款项都将自动退回钱包余额。）" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height)];
    CGSize size6 = [self drawWithStr:@"钱包如何使用？" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height)];
    CGSize size7 = [self drawWithStr:@"1. 钱包内的余额可用于支付未特殊说明的所有订单，包括团购、订餐、午餐等。若余额不足以支付订单金额，则不足部分仍需继续使用其他方式予以支付；若余额金额较多，支付订单后仍有剩余，则剩余部分再次购买时可继续使用。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height)];
    CGSize size8 = [self drawWithStr:@"“交易记录”模块包含钱包余额使用明细可供查看。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height)];
    CGSize size9 = [self drawWithStr:@"“设置密码”模块可设置支付密码、修改支付密码，如您忘记支付密码，可通过注册绑定的手机号获取验证码并重新设置密码。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + size8.height)];
    
    CGFloat height2 = 10;
    CGSize size10 = [self drawWithStr:@"钱包余额如何提现？" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + size8.height + size9.height + height2)];
    
    CGSize size11 = [self drawWithStr:@"嘿唐钱包内的余额支持提现功能。于钱包内选择“提现”，并输入您打算提现的银行卡信息，我们将于7个工作日内将您的款项汇至该银行卡内。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + size8.height + size9.height + height2 + size10.height)];
    
    [self drawWithStr:@"注：购买会员资格时赠送的可抵现金额，自赠送日起2个月内不支持提现功能。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + height1 + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + size8.height + size9.height + height2 + size10.height + size11.height)];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
