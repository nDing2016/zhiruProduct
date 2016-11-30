//
//  ZRErrorController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRErrorController : UIViewController

@property (nonatomic , assign) BOOL  isMeiWang;
@property (nonatomic , copy) void(^clickBtn)();
@end
