//
//  ZRLoginViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"

@protocol loginDelegate <NSObject>

- (void)userLogin;

@end

@interface ZRLoginViewController : ZRBaseViewController

@property (nonatomic, assign)id<loginDelegate>delegate;

@end
