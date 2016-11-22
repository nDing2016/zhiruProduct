//
//  ZREvaluateHeader.h
//  zhiruProduct
//
//  Created by pj on 16/10/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZREvaluateHeader : UIView

@property (nonatomic, strong)UIView * menuBackView;
@property (nonatomic, strong)UILabel * menuTitleLabel;
@property (nonatomic, strong)UILabel * menuContentLabel;
@property (nonatomic, strong)UIView * lineView1;

@property (nonatomic, strong)UIView * starBackView;
@property (nonatomic, strong)UILabel * starTitleLabel;
@property (nonatomic, strong)UIView * lineView2;

@property (nonatomic, strong)UIView * pointBackView;
@property (nonatomic, strong)UILabel * tasteTitleLabel;
@property (nonatomic, strong)UILabel * serveTitleLabel;
@property (nonatomic, strong)UIView * lineView3;

@property (nonatomic, strong)UITextView * textView;
@property (nonatomic, strong)UILabel * textPlaceLabel;
@property (nonatomic, strong)UILabel * textFootLabel;
@end
