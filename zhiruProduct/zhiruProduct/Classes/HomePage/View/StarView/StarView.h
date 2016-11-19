//
//  StarView.h
//  StarScoreDemo
//
//  Created by StarLord on 15/7/28.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
//starHighLightImage:(NSString *)LightImage starNormalImage: (NSString *)normalImage
@property (nonatomic, assign) CGFloat percent; //进度0-1
@property (nonatomic, copy) NSString * lightImage ;
@property (nonatomic, copy) NSString * normalImage ;
@end
