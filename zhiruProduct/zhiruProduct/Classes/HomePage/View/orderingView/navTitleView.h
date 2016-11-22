//
//  navTitleView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *userLoction;


@property (nonatomic , copy) void (^navTitleClick)();

@end
