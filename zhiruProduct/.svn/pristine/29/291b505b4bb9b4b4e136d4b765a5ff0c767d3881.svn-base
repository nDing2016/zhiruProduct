//
//  UITextView+ZSC.h
//  WineAndRose
//
//  Created by ZSC on 16/1/5.
//  Copyright © 2016年 ZSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITextView (ZSC)<UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;
//@property (nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
- (void)addPlaceHolder:(NSString *)placeHolder andMaxCount:(int)maxCount andDidChangeBlock:(void(^)(int))didChangeBlock;

@end
