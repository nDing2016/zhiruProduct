//
//  orderingSectionView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  订餐中section视图

#import <UIKit/UIKit.h>

@interface orderingSectionView : UIView

@property (nonatomic ,assign) NSInteger index;
//@property (nonatomic , assign) BOOL  isLunch;
@property (nonatomic , assign) CGFloat scw;
@property (nonatomic ,copy) void (^btnClick)(NSInteger index);


@end
