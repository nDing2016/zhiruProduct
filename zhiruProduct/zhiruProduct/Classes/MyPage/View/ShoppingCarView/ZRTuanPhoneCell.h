//
//  ZRTuanPhoneCell.h
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRTuanPhoneCell : UITableViewCell

// 线1
@property (nonatomic, strong)UIView * lineView1;
// 头部标识
@property (nonatomic, strong)UILabel * headerLabel;
// phone
@property (nonatomic, strong)UILabel * phoneLabel;
// 线2
@property (nonatomic, strong)UIView * lineView2;
// 右箭头
@property (nonatomic, strong)UIImageView * imgView;
// 底部标识
@property (nonatomic, strong)UILabel * footerLabel;
// 线3
@property (nonatomic, strong)UIView * lineView3;

@end
