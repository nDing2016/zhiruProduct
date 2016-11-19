//
//  ZRPostCommentheadView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRPostCommentheadView : UIView
@property (weak, nonatomic) IBOutlet UIView *overallGrade; //总体评分
@property (weak, nonatomic) IBOutlet UIView *tasteGrade; //口味评分

@property (weak, nonatomic) IBOutlet UIView *environmentGrade;//环境评分

@property (weak, nonatomic) IBOutlet UIView *serviceGrade; //服务评分

@property (weak, nonatomic) IBOutlet UITextView *userWord; //用户评价

@property (weak, nonatomic) IBOutlet UITextField *perCapita; //人均消费

@property (weak, nonatomic) IBOutlet UILabel *placeholderText;
@property (weak, nonatomic) IBOutlet UILabel *Tooltips;


@end
