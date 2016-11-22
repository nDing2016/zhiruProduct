//
//  ZRLunchSectionView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/10/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRLunchSectionView : UIView

@property (nonatomic ,assign) NSInteger index;
//@property (nonatomic , assign) BOOL  isLunch;
@property (nonatomic , assign) CGFloat scw;
@property (nonatomic ,copy) void (^btnClick)(NSInteger index);
@end
