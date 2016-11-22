//
//  ZRBusinessDetailsCollectionCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZROrderingBusinessMsgModel.h"
@interface ZRBusinessDetailsCollectionCell : UICollectionViewCell

@property (nonatomic , strong) ZROrderingBusinessMsgModel * model;

@property (nonatomic , assign) BOOL  isLunch;
@end
