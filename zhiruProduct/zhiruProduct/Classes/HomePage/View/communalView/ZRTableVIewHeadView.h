//
//  ZRTableVIewHeadView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  公用控制器头视图, 使用时 直接设置为 tableview的头视图即可.

#import <UIKit/UIKit.h>

@interface ZRTableVIewHeadView : UIView


/**
 *  头部视图图片点击回调
 */
@property (nonatomic , copy) void(^clickImgView)(NSInteger index);

/**
 *  创建头部视图对象方法
 *
 *  @param frame    frame
 *  @param titleArr 标题名称集合
 *
 *  @return 头部视图
 */
- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray * )titleArr andTitleImgArr :(NSArray*)titleImgArr;




@end
