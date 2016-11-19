//
//  ZRHeaderView.h
//  zhiruProduct
//
//  Created by pj on 16/7/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol senderDelegate <NSObject>

- (void)selectSender:(UIButton *)button;

@end

@interface ZRHeaderView : UIView

@property (nonatomic, strong)NSArray * array;

@property (nonatomic, strong)UILabel * viewLabel;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, weak)id<senderDelegate>delegate;
@end
