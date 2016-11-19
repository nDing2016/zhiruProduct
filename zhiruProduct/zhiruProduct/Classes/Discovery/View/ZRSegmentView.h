//
//  ZRSegmentView.h
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRSegmentView;

@protocol ZRSegmentViewDelegate <NSObject>

/**
 *  按钮点击事件
 */
- (void)segmentView:(ZRSegmentView *)segmentView index:(NSInteger)index;

@end

@interface ZRSegmentView : UIView


@property (nonatomic, weak) id<ZRSegmentViewDelegate> delegate;

/**
 *  按钮标题
 */
@property(nonatomic,strong)NSArray *titleArray;

/**
 *  选中状态背景颜色
 */
@property(nonatomic,strong)UIColor *backgroundSeletedColor;

/**
 *  默认状态背景颜色
 */
@property(nonatomic,strong)UIColor *backgroundNormalColor;

/**
 *  下划线的颜色
 */
@property(nonatomic,strong)UIColor *linColor;

/**
 *  文字大小
 */
@property(nonatomic,strong)UIFont *textFont;

/**
 *  文字默认状态颜色
 */
@property(nonatomic,strong)UIColor *textNormalColor;

/**
 *  文字选中状态颜色
 */
@property(nonatomic,strong)UIColor *textSeletedColor;


/**
 *  加载标题显示的方法
 */
- (void)loadTitleArray:(NSArray *)titleArray;


/**
 *  加载标题显示的方法2
 */
- (void)loadNomalTitleArray:(NSArray *)titleArray;



- (void)buttonPressed:(UIButton *)sender;


@end
