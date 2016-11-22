//
//  ZRProductDetailCell.h
//  zhiruProduct
//
//  Created by nanding on 16/9/3.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRProductDetailModel;
@interface ZRProductDetailCell : UITableViewCell

+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath;


@property (nonatomic, strong) ZRProductDetailModel *productDetails;

@end
