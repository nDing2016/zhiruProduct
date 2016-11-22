//
//  ZRPointsRuleView.m
//  zhiruProduct
//
//  Created by pj on 16/9/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointsRuleView.h"

@implementation ZRPointsRuleView


- (void)drawRect:(CGRect)rect
{
    CGFloat pointY = 15;
    CGSize size1 = [self drawWithStr:@"积分是什么" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"积分是在嘿唐App进行各种操作给予的奖励，用户初始积分为0。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height = 10;
    CGSize size3 = [self drawWithStr:@"积分有什么用？" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height + height)];
    CGSize size4 = [self drawWithStr:@"1. 积分可用于兑换积分商城礼品，每样产品已标注所需积分数额，如积分额度足够，即可兑换，积分商城礼品不可退换。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height + height + size3.height)];
    CGSize size5 = [self drawWithStr:@"2. 会员兑换积分商城礼品，一律享受8.8折，如1000积分可兑换的礼品，会员仅需880积分即可兑换。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height + height + size3.height + size4.height)];
    CGSize size6 = [self drawWithStr:@"积分使用限制：积分兑换商品请在有效期内予以使用，具体详见具体兑换商品规则。是否有可兑换商品，以积分页面实际显示为准。" Font:[UIFont systemFontOfSize:14] Color:RGBCOLOR(149, 149, 149) Point:CGPointMake(0, pointY + size1.height + size2.height + height + size3.height + size4.height + size5.height)];
    
    CGFloat height2 = 10;
    
    CGSize size7 = [self drawWithStr:@"如何获得积分？" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height + height + size3.height + size4.height + size5.height + size6.height + height2)];
    
    CGSize size8 = [self drawWithStr:@"1. 积分自2016年10月15日开始积累。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height + height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height)];
    CGSize size9 = [self drawWithStr:@"2. 点评获取积分。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height)];
    CGSize size10 = [self drawWithStr:@"①直接就店铺进行点评，无需有任何消费，满15字即可获得5积分；\n②直接就店铺进行点评，无需有任何消费，满100字并上传三张照片，经审核后入选“精选点评”即可获得50积分；\n③购买团购并验券后进行点评，满15字即可获得10积分，满100字并上传三张照片，经审核后入选“精选点评”即可获得60积分；\n④在线订餐付款并完成订单后进行点评，满15字即可获得10积分，满100字并上传三张照片，经审核后入选“精选点评”即可获得60积分。" Font:[UIFont systemFontOfSize:14] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height)];
    CGSize size11 = [self drawWithStr:@"3. 消费获取积分。积分获得比例：消费1加币=1积分。；" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height)];
    //
    CGSize size12 = [self drawWithStr:@"如：消费50刀获得50积分，如未满整数则取整数金额，即消费46.6刀自动获得46积分" Font:[UIFont systemFontOfSize:14] Color:RGBCOLOR(149, 149, 149) Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height)];
    CGSize size13 = [self drawWithStr:@"①购买团购券并完成验券后，即可按比例获得相应积分；\n②在线订餐付款并完成订单后，即可按比例获得相应积分。" Font:[UIFont systemFontOfSize:14] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height)];
    CGSize size14 = [self drawWithStr:@"4. 成为会员获取积分。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height)];
    CGSize size15 = [self drawWithStr:@"购买普通会员资格即可获得300积分；" Font:[UIFont systemFontOfSize:14] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height)];
    CGSize size16 = [self drawWithStr:@"5. 嘿唐开展的重大活动，可能会增加积分获得的倍数，具体以活动公告为准。" Font:[UIFont systemFontOfSize:15] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height)];
    
    CGFloat height3 = 10;
    CGSize size17 = [self drawWithStr:@"积分退还" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + height3 + size16.height)];
    
    CGSize size18 = [self drawWithStr:@"当积分商城的产品库存未及时更新，用户已兑换但无法领取礼品时，使用的积分将全部退还。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + height3 + size16.height + size17.height)];
    
    CGFloat height4 = 10;
    CGSize size19 = [self drawWithStr:@"积分的有效期" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + height3 + size16.height + size17.height + size18.height + height4)];
    [self drawWithStr:@"从获得积分开始，积分的有效期为两整年，请在有效期内使用积分，逾期自动作废。" Font:[UIFont boldSystemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(0, pointY + size1.height + size2.height +  height + size3.height + size4.height + size5.height + size6.height + height2 + size7.height + size8.height + size9.height + size10.height + size11.height + size12.height + size13.height + size14.height + size15.height + height3 + size16.height + size17.height + size18.height + height4 + size19.height)];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
