//
//  ZRGroupBuyDetailsFrame.h
//  zhiruProduct
//
//  Created by nanding on 16/8/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZRGroupBuyDetailModel;
@interface ZRGroupBuyDetailsFrame : NSObject

@property (nonatomic, strong) ZRGroupBuyDetailModel *groupDetailsModel;
//有效期
@property (nonatomic, assign) CGRect effectiveDateTitleFrame;
@property (nonatomic, assign) CGRect effectiveDateFrame;

//除外日期
@property (nonatomic, assign) CGRect exceptDateTitleFrame;
@property (nonatomic, assign) CGRect exceptDateFrame;

//使用时间
@property (nonatomic, assign) CGRect applicableTimeTitleFrame;
@property (nonatomic, assign) CGRect applicableTimeFrame;

//预约提醒
@property (nonatomic, assign) CGRect remindTitleFrame;
@property (nonatomic, assign) CGRect remindFrame;

//规则提醒
@property (nonatomic, assign) CGRect ruleTitleFrame;
@property (nonatomic, assign) CGRect ruleFrame;

//商家服务
@property (nonatomic, assign) CGRect deskTitleFrame;
@property (nonatomic, assign) CGRect deskFrame;

//cell高度
@property (nonatomic, assign) CGFloat cellHeight;




@end
