//
//  ZRPostCommentController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  发表评论

#import "ZRBaseViewController.h"

@interface ZRPostCommentController : ZRBaseViewController

@property (nonatomic , copy) NSString * businessId;
@property (nonatomic, copy)NSString * commentType; //1 店铺 2 团购

@property (nonatomic , copy) void (^postOkBlock)();
@end
