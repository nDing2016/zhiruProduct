//
//  ZROrderDetailsCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSuperDetailsModel;
@interface ZROrderDetailsCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *idxPath;
@property (nonatomic, strong) NSArray *productsArr;


@property (nonatomic, strong) NSArray *orderDetailsArray;
@property (nonatomic, assign) NSInteger orderType;

+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath;

@property (nonatomic, strong) ZRSuperDetailsModel *superDetailsModel;

@end
