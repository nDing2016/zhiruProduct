//
//  ZRImmediatelyExchangeCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRUserFindAddressModel;
@protocol ZRImmediatelyExchangeDelegate <NSObject>

- (void)plusOrMinusWithArray:(NSMutableArray *)array;

@end

@interface ZRImmediatelyExchangeCell : UITableViewCell


@property (nonatomic, strong) NSMutableArray *addressArr;

@property (nonatomic, weak) id<ZRImmediatelyExchangeDelegate> delegate;
//地址
@property (nonatomic, strong) ZRUserFindAddressModel *addModel;

+ (ZRImmediatelyExchangeCell *)cellWithTable:(UITableView *)table IndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, copy) NSString *myPoints;


@end
