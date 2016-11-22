//
//  ZRSuperOrderFrame.h
//  zhiruProduct
//
//  Created by nanding on 16/11/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRSuperDetailsModel.h"

@interface ZRSuperOrderFrame : NSObject

@property (nonatomic, strong) ZRSuperDetailsModel *superDetailsModel;

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;


@end
