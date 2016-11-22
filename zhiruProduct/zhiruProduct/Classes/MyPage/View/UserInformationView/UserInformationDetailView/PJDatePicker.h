//
//  PJDatePicker.h
//  pickerViewdemo
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 piao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol datePickerDelegate <NSObject>

- (void)datePickerString:(NSString *)string;

- (void)datePikcerViewState;

@end

@interface PJDatePicker : UIView
@property (nonatomic, strong) NSString *creentDateString;
@property (nonatomic, strong) UIDatePicker *dataPicker;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * headerView;
@property (nonatomic, strong)UIView * footView;
@property (nonatomic, strong)UIButton * cancelButton;
@property (nonatomic, strong)UIButton * okButton;

@property (nonatomic, assign)id<datePickerDelegate>delegate;
- (void)setMinDateStr:(NSString *)minDateStr MaxDateStr:(NSString *)maxDateStr;
@end
