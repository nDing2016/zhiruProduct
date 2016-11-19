//
//  ZRMyPageHeaderView.h
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRMyPageContentView.h"
@interface ZRMyPageHeaderView : UIView

@property (nonatomic, strong)UIView * headerView;
@property (nonatomic, strong)UIImageView * headerImageView;
@property (nonatomic, strong)UILabel * userNameLabel;
@property (nonatomic, strong)UILabel * vipLabel;
@property (nonatomic, strong)UIImageView * rightImageView;
@property (nonatomic, strong)UIView * lineView;

@property (nonatomic, strong)UIView * footerView;
@property (nonatomic, strong)ZRMyPageContentView * footerView1;
@property (nonatomic, strong)UIView * footerLine1;
@property (nonatomic, strong)ZRMyPageContentView * footerView2;
@property (nonatomic, strong)UIView * footerLine2;
@property (nonatomic, strong)ZRMyPageContentView * footerView3;

@property (nonatomic, strong)UIButton * headerButton;

@end
