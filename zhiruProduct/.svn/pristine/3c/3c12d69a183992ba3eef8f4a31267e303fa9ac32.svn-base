//
//  ZRProblemFourView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemFourView.h"

@implementation ZRProblemFourView



- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    
    CGSize size1 = [self drawWithStr:@"1. 我的订单进行到哪一步了？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"点击我的→我的订单→订餐→更多状态，即可获取订单当前状态。您可以获知您的订单是否被商家确认，以及订单是否正在配送等信息。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 如何取消订单？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"点击我的→我的订单→订单→取消订单，即可申请取消订单。若商家尚未接单，您可以直接取消订单；若商家已接单，请您尽快联系商家取消，商家同意后将会为您退款。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 我的订单为什么被取消了？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    [self drawWithStr:@"取消订单可能有以下几种情况：\n系统自动取消，如果商家15分钟内未接单，为了不耽误您的用餐，系统会自动取消；\n电话无人接听，商家接单后无法联系上您，不能完成配送；\n菜品售完。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
    }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
