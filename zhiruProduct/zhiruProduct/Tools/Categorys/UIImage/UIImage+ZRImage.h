//
//  UIImage+ZRImage.h
//  zhiruProduct
//
//  Created by nanding on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZRImage)


+(UIImage*)imageWithPingfenCount:(CGFloat)pingfenCount;

/**
 *  加载网络图片
 *
 *  @param fileURL URL
 *
 *  @return image
 */
+(UIImage *) getImageFromURL:(NSString *)fileURL;


@end
