//
//  ZRGroupBuyCommentFrame.h
//  zhiruProduct
//
//  Created by nanding on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZRGroupCommentListModel;
@interface ZRGroupBuyCommentFrame : NSObject

@property (nonatomic, strong) ZRGroupCommentListModel *commentListModel;

//评论人头像
@property (nonatomic, assign) CGRect commentUserImgFrame;

//评论人
@property (nonatomic, assign) CGRect commentUserNameFrame;

//星级
@property (nonatomic, assign) CGRect commentGradeFrame;

//人均消费
@property (nonatomic, assign) CGRect perCapitaFrame;

//评论内容
@property (nonatomic, assign) CGRect commentContentFrame;

//评论时间
@property (nonatomic, assign) CGRect commentDateFrame;

//向上大拇指数
@property (nonatomic, assign) CGRect goodFrame;
@property (nonatomic, assign) CGRect goodImgFrame;

//向下大拇指数
@property (nonatomic, assign) CGRect notGoodFrame;
@property (nonatomic, assign) CGRect notGoodImgFrame;

//评论图片
@property (nonatomic, strong) NSArray *commentImgArray;

@property (nonatomic, assign) CGRect commentImgFrame;


//行高
@property (nonatomic, assign) CGFloat cellHeight;
 


@end
