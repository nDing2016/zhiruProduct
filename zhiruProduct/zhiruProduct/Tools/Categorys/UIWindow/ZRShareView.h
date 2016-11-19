//
//  ZRShareView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRShareView : UIView

/**
 *  分享图片加链接
 *
 *  @param title   题目
 *  @param text    内容
 *  @param images  图片数组
 *  @param urlStr  url
 *  @param success 成功
 *  @param fail    失败
 *  @param cancle  取消
 */
- (void)createUIWithTitle:(NSString *)title
                  andText:(NSString *)text
                andImages:(NSArray *)images
                andUrlStr:(NSString *)urlStr
               andSuccess:(void (^)(void))success
                  andFail:(void (^)(void))fail
                andCancle:(void (^)(void))cancle;


@end
