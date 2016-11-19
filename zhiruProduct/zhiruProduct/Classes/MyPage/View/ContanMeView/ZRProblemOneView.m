//
//  ZRProblemOneView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemOneView.h"

@implementation ZRProblemOneView

- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    
    CGSize size1 = [self drawWithStr:@"1. 如何通过微信、支付宝付加币？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"我们每日即时获取中国银行外汇牌价，取加币兑人民币现汇卖出价，将加币按此汇率折算为人民币，再通过微信、支付宝直接支付人民币。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 取消订单后退款到哪里了" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"在嘿唐平台取消已支付的订单，并发生退款后，无论此前用任何方式支付的订单，款项都将退回嘿唐钱包余额。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 在钱包余额里的钱怎么转出来？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    CGSize size6 = [self drawWithStr:@"嘿唐钱包内的余额支持提现功能。于钱包内选择“提现”，并输入您打算提现的银行卡信息，我们将于7个工作日内将您的款项汇至该银行卡内。会员享“极速退款”功能，将于3个工作日内退回你的银行卡内。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
    CGFloat height3 = 10;
    
    CGSize size7 = [self drawWithStr:@"4. 钱包余额里的钱提现失败了怎么回事？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + height1 + height2 + height3)];
    [self drawWithStr:@"钱包余额里的钱提现失败可能有以下原因：\n银行卡或账户信息填写错误，请确认填写的信息无误；\n银行卡或账户由于其他原因不可用，导致转账失败，请您联系银行确认账户的有效性。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
