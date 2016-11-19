//
//  UITextView+ZSC.m
//  WineAndRose
//
//  Created by ZSC on 16/1/5.
//  Copyright © 2016年 ZSC. All rights reserved.
//

#import "UITextView+ZSC.h"

static const char *phTextView = "placeHolderTextView";

static NSInteger kMaxCount = 0;

static void(^myDidChangeBlock)(int count);

@implementation UITextView (ZSC)

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}
- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)addPlaceHolder:(NSString *)placeHolder andMaxCount:(int)maxCount andDidChangeBlock:(void(^)(int))didChangeBlock{
    if (![self placeHolderTextView]) {
        self.delegate = self;
        kMaxCount = maxCount;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
        
        myDidChangeBlock = didChangeBlock;
    }
}

# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

#pragma mark - 限制输入字符串长度
- (void)textViewDidChange:(UITextView *)textView
{
        NSString *toBeString = textView.text;
        
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage ;
        
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            
            UITextRange *selectedRange = [textView markedTextRange];
            
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > kMaxCount) {
                    textView.text = [toBeString substringToIndex:kMaxCount];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{

            }
        } // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        else{
            if (toBeString.length > kMaxCount)
            {
                textView.text = [toBeString substringToIndex:kMaxCount];
                myDidChangeBlock(0);
                return;
            }
        }
    
    myDidChangeBlock((int)(kMaxCount-textView.text.length));
    
}


@end
