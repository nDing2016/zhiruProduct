//
//  ZRGroupBuyingDetailsCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRGroupBuyDetailModel.h"
@class ZRGroupBuyDetailsFrame;
@interface ZRGroupBuyingDetailsCell : UITableViewCell

+(instancetype)cellWithTable:(UITableView *)table forIndexPath:(NSIndexPath *)idxPath WithData:(ZRGroupBuyDetailModel *)detailsModel;

@property (nonatomic, strong) NSIndexPath *idxPath;

//@property (nonatomic, strong) UIImage *headImage;
//@property (nonatomic, copy) NSString *saledCount;
//
//@property (nonatomic, assign) BOOL freeAppointment;

@property (nonatomic, strong) ZRGroupBuyDetailModel *detailsModel;

@property (nonatomic, strong) ZRGroupBuyDetailsFrame *groupDetailsFrame;

@end
