//
//  ZRSelectAddressCell.h
//  zhiruProduct
//
//  Created by pj on 16/10/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZRUserAddressModel.h"

@protocol ZRSelectAddressCellDelegate <NSObject>

- (void)getSelectButtonState:(UIButton *)sender;

@end

@interface ZRSelectAddressCell : UITableViewCell

@property (nonatomic, strong)UIButton * selectBtn;

@property (nonatomic, strong)UILabel * nameLabel;

@property (nonatomic, strong)UILabel * genderLabel;

@property (nonatomic, strong)UILabel * phoneLabel;

@property (nonatomic, strong)UILabel * addressLabel;

@property (nonatomic, strong)ZRUserAddressModel * model;

@property (nonatomic, assign)id<ZRSelectAddressCellDelegate>delegate;


@end
