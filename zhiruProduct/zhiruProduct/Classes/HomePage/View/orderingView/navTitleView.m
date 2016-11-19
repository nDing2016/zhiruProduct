//
//  navTitleView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "navTitleView.h"

@implementation navTitleView


//点击标题 跳转定位界面
- (IBAction)navTitleClick:(id)sender {

    if (self.navTitleClick) {
        self.navTitleClick();
    }
}

@end
