//
//  ZRPointsHeaderView.h
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRSectionHeaderView.h"
@interface ZRPointsHeaderView : UIView

@property (nonatomic, strong)UIImageView * headerImage;
@property (nonatomic, strong)UILabel * pointLabel;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)ZRSectionHeaderView * sectionHeaderView;
@end
