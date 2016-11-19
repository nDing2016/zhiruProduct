//
//  ZRProblemTwoView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemTwoView.h"

@implementation ZRProblemTwoView


- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    
    CGSize size1 = [self drawWithStr:@"1. 我发现店铺信息错误怎么办" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"如果您发现我们提供的店铺信息有纰漏，请及时联系我们更正，感谢您提供的正确信息！" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 购买团购后如何进店消费？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"点击我的→我的团购券，查看已购买的团购券码及有限期限，点击团购券可查看订单详情。或点击我的→我的订单→团购，查看已购买的团购订单详情。\n到店后，将已选团购产品及团购券码告诉商家，即可享受团购券所标准的服务。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 需要预定的团购如何预定呢？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    CGSize size6 = [self drawWithStr:@"部分团购有预约要求，在购买须知的预约提醒部分会进行详细说明。请您于店铺工作时间范围内，拨打嘿唐平台提供的联系电话，与商家进行预约，感谢您的理解。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
    CGFloat height3 = 10;
    
    CGSize size7 = [self drawWithStr:@"4. 到店后商家表示无法提供团购怎么办？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + height1 + height2 + height3)];
    [self drawWithStr:@"到店后，如果商家表示无法提供团购，或商家表示可以直接以团购价消费，请您及时与我们取得联系，联系方式在页面的末尾提供，感谢您的配合。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
