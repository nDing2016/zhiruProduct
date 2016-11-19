//
//  ZRShoppingCarFooterView.h
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol footSelectButtonDelegate <NSObject>

- (void)footViewSlelectButton:(UIButton *)sender;

- (void)footViewClearingButton:(UIButton *)sender;
@end

@interface ZRShoppingCarFooterView : UIView

@property (nonatomic, strong)UIButton * selectButton;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * moneyLabel;
@property (nonatomic, strong)UIButton * clearingButton;
@property (nonatomic, strong)UIView * lineView;


@property (nonatomic, assign)BOOL clearingState;

@property (nonatomic, assign)id<footSelectButtonDelegate>delegate;
@end
