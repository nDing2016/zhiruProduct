//
//  ZRProblemThreeView.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemThreeView.h"

@implementation ZRProblemThreeView


- (void)drawRect:(CGRect)rect
{
    UIFont * font1 = [UIFont boldSystemFontOfSize:16];
    UIFont * font2 = [UIFont systemFontOfSize:15];
    UIColor * blackColor = [UIColor blackColor];
    CGFloat pointY = 15;
    
    CGSize size1 = [self drawWithStr:@"1. 如何通过写点评获得积分？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY)];
    CGSize size2 = [self drawWithStr:@"点击我的→我的积分→积分规则，可查看点评获得积分的方式。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height)];
    
    CGFloat height1 = 10;
    
    CGSize size3 = [self drawWithStr:@"2. 如何入选“精选点评”？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + height1)];
    CGSize size4 = [self drawWithStr:@"首先精选点评必须满100字并上传三张照片，如果您的点评非常认真客观且具有很强的可参考性，那么此条点评即有机会入选“精选点评”，获得更多积分。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + height1)];
    
    
    CGFloat height2= 10;
    
    CGSize size5 = [self drawWithStr:@"3. 为什么我的评论发布失败了？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + height1 + height2)];
    CGSize size6 = [self drawWithStr:@"首先评论字数最少为15个字符，少于15个字符无法评论。\n另外，如果您的网络状况不好，可能引起上传评论失败，请您检测网络环境后再次评价。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + height1 + height2)];
    
    CGFloat height3 = 10;
    
    CGSize size7 = [self drawWithStr:@"4. 我的评论为什么没有展示？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + height1 + height2 + height3)];
    CGSize size8 = [self drawWithStr:@"您的评论没有展示的原因可能有以下几种：\n违反公共道德和法律规定的内容无法展示；\n图文并非本人原创，如抄袭他人评论或盗图等；\n灌水信息，如凑字乱打，上传无关图片等。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3)];
    
    CGFloat height4 = 10;
    
    CGSize size9 = [self drawWithStr:@"5. 为什么我的点评被屏蔽/被删除了？" Font:font1 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3 + size8.height + height4)];
    
    [self drawWithStr:@"嘿唐平台是一个消费体验共享的平台，点评必须是普通消费者真实体验后的客观评价，不鼓励任何形式的刷分、灌水及其他不正当竞争行为，也决不允许任何方式炒作、养马甲行为。如果您的评价涉及以上情况，或被商家举报涉嫌恶意竞争，我们将酌情屏蔽/删除你的评论。如有疑问，请与我们取得联系，联系方式在页面的末尾提供，感谢您的理解。" Font:font2 Color:blackColor Point:CGPointMake(0, pointY + size1.height + size2.height + size3.height + size4.height + size5.height + size6.height + size7.height + height1 + height2 + height3 + size8.height + height4 + size9.height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
