//
//  ZRExplainViewController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  说明界面,  比如 配送说明,等

#import "ZRBaseViewController.h"

@interface ZRExplainViewController : ZRBaseViewController
//如果 type == 1 重量费说明
@property (nonatomic , assign) NSInteger  type;
@end
