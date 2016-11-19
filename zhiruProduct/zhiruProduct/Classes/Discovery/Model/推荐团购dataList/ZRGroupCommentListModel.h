//
//  ZRGroupCommentListModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRGroupCommentListModel : NSObject

//评论id
@property (nonatomic, copy) NSString *commentId;

//评论人id
@property (nonatomic, copy) NSString *commentUserId;

//评论人
@property (nonatomic, copy) NSString *commentUserName;

//评论人头像
@property (nonatomic, copy) NSString *commentUserImg;

//评论内容
@property (nonatomic, copy) NSString *commentContent;

//星级
@property (nonatomic, copy) NSString *commentGrade;

//人均消费
@property (nonatomic, copy) NSString *perCapita;

//向上大拇指数
@property (nonatomic, copy) NSString *good;

//向下大拇指数
@property (nonatomic, copy) NSString *notGood;

//评论时间
@property (nonatomic, copy) NSString *commentDate;

//评论图片
@property (nonatomic, strong) NSArray *commentImg;






















@end
