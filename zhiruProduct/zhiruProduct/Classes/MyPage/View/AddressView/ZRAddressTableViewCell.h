//
//  ZRAddressTableViewCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRUserAddressModel;

@interface ZRAddressTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * nameLabel;
@property (nonatomic, strong)UILabel * sexLabel;
@property (nonatomic, strong)UILabel * phoneNumberLabel;

@property (nonatomic, strong)UILabel * addressLabel;
@property (nonatomic, strong)UIImageView * modifyImage;

@property (nonatomic, strong)UIView * lineView;

@property (nonatomic, strong)UIView * backFootView;
@property (nonatomic, strong)UIButton * selectButton;
@property (nonatomic, strong)UILabel * contentLabel;

//@property (nonatomic, strong)NSString * str1;
//@property (nonatomic, strong)NSString * str2;
//@property (nonatomic, strong)NSString * str3;
//@property (nonatomic, strong)NSString * str4;

@property (nonatomic, strong)ZRUserAddressModel * model;


@end
