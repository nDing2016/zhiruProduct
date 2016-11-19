//
//  ZRGroupBuyDetailsFrame.m
//  zhiruProduct
//
//  Created by nanding on 16/8/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyDetailsFrame.h"
#import "ZRGroupBuyDetailModel.h"

@implementation ZRGroupBuyDetailsFrame

-(void)setGroupDetailsModel:(ZRGroupBuyDetailModel *)groupDetailsModel
{
    _groupDetailsModel = groupDetailsModel;
    [self setAllFrames];
    _cellHeight = CGRectGetMaxY(self.deskFrame)+(15*SCREEN_HEIGHT/667);
}


- (void)setAllFrames
{
    CGFloat x = 15*SCREEN_WIDTH/375;
    CGFloat y = 10*SCREEN_HEIGHT/667;
    CGFloat wid = (SCREEN_WIDTH-2*x);
    //有效期
    CGSize size1 = [NSString getSize:@"有效期" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _effectiveDateTitleFrame = CGRectMake(x, y, size1.width, size1.height);
    
    NSString *effec = [NSString stringWithFormat:@"· %@",_groupDetailsModel.effectiveDates];
    CGSize size11 = [NSString getSize:effec strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _effectiveDateFrame = CGRectMake(x, CGRectGetMaxY(_effectiveDateTitleFrame)+y, size11.width, size11.height);
    
    //除外日期
    CGSize size2 = [NSString getSize:@"除外日期" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _exceptDateTitleFrame = CGRectMake(x, CGRectGetMaxY(_effectiveDateFrame)+y, size2.width, size2.height);
    NSString *except = [NSString stringWithFormat:@"· %@",_groupDetailsModel.exceptionDate];
    CGSize size22 = [NSString getSize:except strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _exceptDateFrame = CGRectMake(x, CGRectGetMaxY(_exceptDateTitleFrame)+y, size22.width, size22.height);
    
    //使用时间
    CGSize size3 = [NSString getSize:@"使用时间" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _applicableTimeTitleFrame = CGRectMake(x, CGRectGetMaxY(_exceptDateFrame)+y, size3.width, size3.height);
    NSString *applica = [NSString stringWithFormat:@"· %@",_groupDetailsModel.applicableTime];
    CGSize size33 = [NSString getSize:applica strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _applicableTimeFrame = CGRectMake(x, CGRectGetMaxY(_applicableTimeTitleFrame)+y, size33.width, size33.height);
    
    //预约提醒
    CGSize size4 = [NSString getSize:@"预约提醒" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _remindTitleFrame = CGRectMake(x, CGRectGetMaxY(_applicableTimeFrame)+y, size4.width, size4.height);
    NSString *remind = [NSString stringWithFormat:@"· %@",_groupDetailsModel.remind];
    CGSize size44 = [NSString getSize:remind strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _remindFrame = CGRectMake(x, CGRectGetMaxY(_remindTitleFrame)+y, size44.width, size44.height);
    
    
    //规则提醒
    CGSize size5 = [NSString getSize:@"规则提醒" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _ruleTitleFrame = CGRectMake(x, CGRectGetMaxY(_remindFrame)+y, size5.width, size5.height);
    NSString *rule = [NSString stringWithFormat:@"· %@",_groupDetailsModel.rule];
    CGSize size55 = [NSString getSize:rule strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _ruleFrame = CGRectMake(x, CGRectGetMaxY(_ruleTitleFrame)+y, size55.width, size55.height);
    
    //商家服务
    CGSize size6 = [NSString getSize:@"商家服务" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _deskTitleFrame = CGRectMake(x, CGRectGetMaxY(_ruleFrame)+y, size6.width, size6.height);
    NSString *desk = [NSString stringWithFormat:@"· %@",_groupDetailsModel.deskDescription];
    CGSize size66 = [NSString getSize:desk strFont:CustomFont(15) maxSize:CGSizeMake(wid, SCREEN_HEIGHT)];
    _deskFrame = CGRectMake(x, CGRectGetMaxY(_deskTitleFrame)+y, size66.width, size66.height);

}

@end
