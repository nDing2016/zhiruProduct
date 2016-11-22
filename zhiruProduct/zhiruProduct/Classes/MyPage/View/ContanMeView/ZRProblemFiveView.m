//
//  ZRProblemFiveView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemFiveView.h"

@implementation ZRProblemFiveView


- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    
    CGSize size1 = [self drawWithStr:@"1. 为什么我无法参加优惠活动？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"可能是您的设备、手机号、支付账号等参加过此活动，活动购买次数有限，请您查看是否超出购买次数。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 为什么我无法使用抵用券或优惠券？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"请您检查以下信息：\n您的订单是否达到最低使用金额；\n您是否超出使用张数限制；\n该抵用券或优惠券是否显示仅限新客使用（该设备、手机号、银行卡、支付账号均是第一次使用者定义为新客）；\n您的客户端是否是最新版本。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 我是商家，如何进行合作？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    [self drawWithStr:@"欢迎您与我们洽谈合作事宜，请点击我的→合作界面，查看更多合作信息。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
