//
//  UIScrollView+ZRRefresh.h
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshCallback)();

@interface UIScrollView (ZRRefresh)

-(void)startRefreshWithCallback:(RefreshCallback)callback;


-(void)startFooterRefreshWithCallback:(RefreshCallback)callback;


- (void)startFooterRefresh:(id)myClass Action:(SEL)action;

@end
