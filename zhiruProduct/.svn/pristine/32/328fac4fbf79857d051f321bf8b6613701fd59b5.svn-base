//
//  PJDatePicker.m
//  pickerViewdemo
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 piao. All rights reserved.
//

#import "PJDatePicker.h"

@implementation PJDatePicker



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBackView];
    }
    return self;
}
- (void)createBackView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 216 - 40)];
    [self.backView setBackgroundColor:[UIColor blackColor]];
    [self.backView setAlpha:0.3];
    [self addSubview:_backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView)];
    tap.numberOfTapsRequired = 1;
    [self.backView addGestureRecognizer:tap];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 216 - 40, self.frame.size.width, 40)];
    [self.headerView setBackgroundColor:RGBCOLOR(236, 236, 236)];
    [self addSubview:_headerView];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 216, self.frame.size.width, 216)];
    [self.footView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_footView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setFrame:CGRectMake(5, 0, 50, 40)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(actionCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_cancelButton];
    
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.okButton setFrame:CGRectMake(self.frame.size.width - 55, 0, 50, 40)];
    [self.okButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(actionOkButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_okButton];
}
- (void)actionCancelButton
{
    [self.delegate datePikcerViewState];
}
- (void)actionOkButton:(UIButton *)btn
{
    [self.delegate datePickerString:_creentDateString];
    
}
- (UIDatePicker *)dataPicker
{
    if (_dataPicker == nil) {
        _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
        [self.footView addSubview:_dataPicker];
        _dataPicker.backgroundColor = [UIColor whiteColor];
        //    _dataPicker.hidden = NO;
        [_dataPicker setDatePickerMode:UIDatePickerModeDate];
        [_dataPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];

    }
    return _dataPicker;
}
- (void)tapBackView
{
    [self.delegate datePikcerViewState];
}
- (void)setMinDateStr:(NSString *)minDateStr MaxDateStr:(NSString *)maxDateStr
{
//    _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 216, self.frame.size.width, 216)];
//    [self addSubview:_dataPicker];
//    _dataPicker.backgroundColor = [UIColor whiteColor];
////    _dataPicker.hidden = NO;
//    [_dataPicker setDatePickerMode:UIDatePickerModeDate];
//    [_dataPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSDateFormatter * formatter_maxDate = [[NSDateFormatter alloc] init];
    [formatter_maxDate setDateFormat:@"yyyy-MM-dd"];
//    NSDate * toDay = [NSDate date];
//    NSString *mixDateString = @"1900-01-01";
//    NSString *maxDateString =  [formatter_maxDate stringFromDate:toDay];
    self.creentDateString = maxDateStr;
    // 最小日期
    NSDate * mixDate = [formatter_maxDate dateFromString:minDateStr];
    // 最大日期
    NSDate * maxDate = [formatter_maxDate dateFromString:maxDateStr];
    
    self.dataPicker.backgroundColor = [UIColor clearColor];
    [_dataPicker setMinimumDate:mixDate];
    [_dataPicker setMaximumDate:maxDate];
    [_dataPicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)dataValueChanged:(UIDatePicker *)sender
{
    UIDatePicker *tmpDatePicker = (UIDatePicker *)sender;
    NSDate *tmpDate = tmpDatePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _creentDateString = [formatter stringFromDate:tmpDate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
