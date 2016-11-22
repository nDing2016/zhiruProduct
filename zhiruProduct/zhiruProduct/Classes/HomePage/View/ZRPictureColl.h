//
//  ZRPictureColl.h
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRPhotosModel.h"
@interface ZRPictureColl : UICollectionViewCell

@property (nonatomic, strong)UIImageView * imgView;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * imgName;

@property (nonatomic, strong)ZRPhotosModel * model;

@end
