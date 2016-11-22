//
//  ZRDetailAddressView.h
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRDetailAddressView : UIView<UITextViewDelegate>

// 收获地址
@property (nonatomic, strong)UILabel * addLabel;
// 定位地址
@property (nonatomic, strong)UITextField * pitchTextField;
// button
@property (nonatomic, strong)UIButton * clearButton;
// lineView
@property (nonatomic, strong)UIView * lineView;
// 输入详细地址
@property (nonatomic, strong)UITextView * textView;
@end
