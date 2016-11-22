//
//  ZRPointDeatilTableViewCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRPointsDeatilModel.h"


@interface ZRPointDeatilTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * pointType;
@property (nonatomic, strong)UILabel * pointSource;
@property (nonatomic, strong)UILabel * pointLabel;
@property (nonatomic, strong)UILabel * timeLabel;

@property (nonatomic, strong)ZRPointsDeatilModel * model;

@end
