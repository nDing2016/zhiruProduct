//
//  ZRVipRuleView.m
//  zhiruProduct
//
//  Created by pj on 16/9/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRVipRuleView.h"

@implementation ZRVipRuleView

- (void)drawRect:(CGRect)rect
{
    CGFloat poingY = 15;
    UIColor * blackColor = [UIColor blackColor];
    UIFont * boldFont = [UIFont boldSystemFontOfSize:16];
    UIFont * sysFont1 = [UIFont systemFontOfSize:15];
    CGSize size1 = [self drawWithStr:@"VIP会员是什么？" Font:boldFont Color:blackColor Point:CGPointMake(0, poingY)];
    CGSize size2 = [self drawWithStr:@"VIP会员是嘿唐平台为用户提供的、可供用户选择的付费服务，配有会员专属权益，具体权益请参见后文。会员身份永久有效，不限地域。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height)];
    
    CGFloat height1 = 10;
    CGSize size3 = [self drawWithStr:@"如何开通会员？" Font:boldFont Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"1. 用户从嘿唐App客户端“我的→我的钱包→成为会员”进入，即可开通会员身份。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height)];
    CGSize size5 = [self drawWithStr:@"2. 用户也可从嘿唐App客户端“我的→个人信息→会员身份”进入（于“我的”界面点击头像右侧空白处即可进入“个人信息”，看到“成为VIP 享特权”字样），即可开通会员身份。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height)];
    CGSize size6 = [self drawWithStr:@"3. 点击购买会员身份后，可通过平台支持的多种支付方式付款。用户支付成功后，系统将立即开通会员身份。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height)];
    
    CGFloat height2= 10;
    CGSize size7 = [self drawWithStr:@"会员权益有什么？" Font:boldFont Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2)];
    CGSize size8 = [self drawWithStr:@"1. 成为嘿唐会员后，即刻赠送200刀抵现金额，自动充入钱包余额。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height)];
    CGSize size9 = [self drawWithStr:@"注：购买会员资格时赠送的可抵现金额，自赠送日起2个月内不支持提现功能。" Font:[UIFont systemFontOfSize:14] Color:RGBCOLOR(156, 156, 156) Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height)];
    CGSize size10 = [self drawWithStr:@"2. 成为嘿唐会员后，即刻赠送300积分，积分可用于兑换积分商城礼品，有关积分的详细说明请参考“积分规则”。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height)];
    CGSize size11 = [self drawWithStr:@"3. 嘿唐会员兑换积分商城礼品，一律享受8.8折，如1000积分可兑换的礼品，会员仅需880积分即可兑换。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height)];
    CGSize size12= [self drawWithStr:@"4. 嘿唐会员于“嗖嗖专送”店铺下单订餐时，享10刀起送价（普通用户起送价15刀）。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height)];
    CGSize size13 = [self drawWithStr:@"注：订餐模块仅“嗖嗖专送”店铺支持起送价立减，商家自送店铺暂不支持。" Font:[UIFont systemFontOfSize:14] Color:RGBCOLOR(156, 156, 156) Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height)];
    CGSize size14 = [self drawWithStr:@"5. 嘿唐会员于我的钱包内进行余额提现时，享受“极速到账”服务，可于3个工作日内到账（普通用户7个工作日内到账）。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height)];
    CGSize size15 = [self drawWithStr:@"6. 嘿唐会员将于各个节日，不定时收到我们送出的小礼品，请您确保电话及地址的准确性。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height)];
    CGSize size16 = [self drawWithStr:@"7. 其他会员权益将陆续开通，如有特殊会员活动，以活动公告为准。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height)];
    
    CGFloat height3 = 10;
    CGSize size17 = [self drawWithStr:@"注意事项" Font:boldFont Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + size16.height + height3)];
    CGSize size18 = [self drawWithStr:@"1. 会员身份获取后，不支持退款或取消会员身份。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + size16.height + height3 + size17.height)];
    CGSize size19 = [self drawWithStr:@"2. 会员身份将绑定开通账号，仅限本人使用，不得授权或转授权他人使用。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + size16.height + height3 + size17.height + size18.height)];
    CGSize size20 = [self drawWithStr:@"3. 嘿唐平台有权变动会员身份价格，但价格变动仅针对新开通的会员，并不会影响现有会员。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + size16.height + height3 + size17.height + size18.height + size19.height)];
    [self drawWithStr:@"4. 在法律允许的范围内，嘿唐平台拥有本规则的解释权。" Font:sysFont1 Color:blackColor Point:CGPointMake(0, poingY + size1.height + size2.height + height1 + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + size16.height + height3 + size17.height + size18.height + size19.height + size20.height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
