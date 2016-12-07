//
//  ZRCarteTableViewCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZROrderingMenuModel.h"
@class ZRCarteTableViewCell, ZRSupermarketGoodsListModel;
@protocol ZRCarteTableViewCellDelegate <NSObject>

- (void)addFoods:(ZRCarteTableViewCell *)cell ForIndexPath:(NSIndexPath *)idxPath;

- (void)minusFoods:(ZRCarteTableViewCell *)cell ForIndexPath:(NSIndexPath *)idxPath;


@end

@interface ZRCarteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *orderingImg;
@property (weak, nonatomic) IBOutlet UILabel *orderingName;
@property (weak, nonatomic) IBOutlet UILabel *orderingPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderingSoldNum;

@property (nonatomic, strong) NSIndexPath *idxPath;
@property (nonatomic, weak) id<ZRCarteTableViewCellDelegate> delegate;

@property (nonatomic, copy) NSString *countStr;
@property (nonatomic , strong) ZROrderingMenuModel * menuModel;
- (void)animateWithMinusBtnOff;
- (IBAction)addBtnClick:(id)sender ;
- (void)minusBtnClick:(UIButton *)sender;


@property (nonatomic, strong) NSMutableArray *productsArr;


@end
