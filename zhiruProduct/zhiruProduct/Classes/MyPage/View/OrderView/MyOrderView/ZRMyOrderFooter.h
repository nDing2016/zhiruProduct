//
//  ZRMyOrderFooter.h
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRFooterDetailView.h"

@protocol buttonDelegate <NSObject>

- (void)selectClickButton:(UIButton *)sender;

@end

@interface ZRMyOrderFooter : UIView

//@property (nonatomic, strong)NSDictionary * dic;

@property (nonatomic, strong)NSMutableArray * array;

@property (nonatomic, assign)id<buttonDelegate>delegate;

@end
