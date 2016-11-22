//
//  ZRCaptchaView.h
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZRCaptchaView : UIView

// 手机区号
@property (nonatomic, strong)UILabel * label;
// 下箭头图片
@property (nonatomic, strong)UIImageView * img;
// 透明按钮-位于手机区号label和下箭头图片的上方
@property (nonatomic, strong)UIButton * clearButton;
// 竖线
@property (nonatomic, strong)UIView * lineView;
// 用户名输入框
@property (nonatomic, strong)UITextField * textField;
// 验证码倒计时按钮
@property (nonatomic, strong)UIButton * captchaButton;
@end
