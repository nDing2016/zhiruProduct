//
//  ZRShopCommentCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRCommentListModel.h"

@interface ZRShopCommentCell : UITableViewCell

@property (nonatomic , strong) ZRCommentListModel * model;
@property (nonatomic , copy) void (^clickGoodBtn)(UIButton *goodAndNoGood , NSString * commentId , BOOL isCancel);
@end
