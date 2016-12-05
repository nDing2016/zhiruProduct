//
//  ZRCommentListModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRCommentListModel : NSObject

/**
 *  评论人头像
 */
@property (nonatomic, copy) NSString *commentUserImg;
/**
 *  评论id
 */
@property (nonatomic , copy) NSString * commentId;

/**
 *  评论人id
 */
@property (nonatomic , copy) NSString * commentUserId;
/**
 *  评论人name
 */
@property (nonatomic , copy) NSString * commentUserName;
/**
 *  评论内容
 */
@property (nonatomic , copy) NSString * commentContent;
/**
 *  星级
 */
@property (nonatomic , copy) NSString * commentGrade;
/**
 *  人均消费
 */
@property (nonatomic , copy) NSString * perCapita;
/**
 *  好评数
 */
@property (nonatomic , copy) NSString * good;
/**
 *  差评数
 */
@property (nonatomic , copy) NSString * notGood;
/**
 *  评论时间
 */
@property (nonatomic , copy) NSString * commentDate;
/**
 *  评论照片
 */
@property (nonatomic , strong) NSArray * commentImg;
/**
 *  是否点击过大拇指
 */
@property (nonatomic , copy) NSString * isClick;
/**
 *  店家回复
 */
@property (nonatomic , copy) NSString * reply;




//详细评价1
@property (nonatomic, copy) NSString *gradeOne;
//详细评价2
@property (nonatomic, copy) NSString *gradeTwo;
//详细评价3
@property (nonatomic, copy) NSString *gradeThree;


//区分寻味丽人娱乐
///**
// 
// /*美食分类id*/
//public static final String DELICIOUSFOOD="24fe49cb9aff4aaeb92f836700387716";
///**娱乐id*/
//public static final String ENTERTAINMENT="d69c3d058ec14ef2bd79e377e64b98de";
///**丽人id*/
//public static final String MODELLING="3f7ca1dc60ff4d2a842f6a351beb2297";
//
//*/
@property (nonatomic, copy) NSString *navId;


@end
