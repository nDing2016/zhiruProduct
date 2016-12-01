//
//  ZRGroupBuyingReviewDetailsCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRGoupBuyingReviewFrame.h"
@class ZRCommentListModel;

@interface ZRGroupBuyingReviewDetailsCell : UITableViewCell

@property (nonatomic, strong) ZRGoupBuyingReviewFrame *reviewFrame;

@property (nonatomic, strong) ZRCommentListModel *commentListModel;


@property (nonatomic, assign) int shoptype;

@property (nonatomic , copy) void (^clickGoodBtn)(UIButton *goodAndNoGood , NSString * commentId , BOOL isCancel);

+(instancetype)cellWithTableView:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath;

@end
