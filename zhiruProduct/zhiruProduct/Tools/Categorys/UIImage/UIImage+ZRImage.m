//
//  UIImage+ZRImage.m
//  zhiruProduct
//
//  Created by nanding on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "UIImage+ZRImage.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (ZRImage)


+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //    if (blur < 0.f || blur > 1.f) {
    //        blur = 0.5f;
    //    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    if (boxSize % 2 == 0) boxSize ++;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             CGImageGetColorSpace(img),
                                             kCGImageAlphaNoneSkipLast);
    
    
    
    
    
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
    
    
    
    
    
}

+(UIImage*)imageWithPingfenCount:(CGFloat)pingfenCount{
    
    if ( pingfenCount >= 1 && pingfenCount <= 1.2) {
        return [UIImage imageNamed:@"1"];
    }else if ( pingfenCount >= 1.3 && pingfenCount < 1.8){
        return [UIImage imageNamed:@"yidianwu"];
    }else if ( pingfenCount >= 1.8 && pingfenCount < 2.3){
        return [UIImage imageNamed:@"2"];
    }else if ( pingfenCount >= 2.3 && pingfenCount < 2.8){
        return [UIImage imageNamed:@"erdianwu"];
    }else if ( pingfenCount >= 2.8 && pingfenCount < 3.3){
        return [UIImage imageNamed:@"3"];
    }else if ( pingfenCount >= 3.3 && pingfenCount < 3.8){
        return [UIImage imageNamed:@"sandianwu"];
    }else if ( pingfenCount >= 3.8 && pingfenCount < 4.3){
        return [UIImage imageNamed:@"4"];
    }else if ( pingfenCount >= 4.3 && pingfenCount <4.8){
        return [UIImage imageNamed:@"sidianwu"];
    }else if( pingfenCount >= 4.8){
        return [UIImage imageNamed:@"5"];
    }else{
        return [UIImage imageNamed:@"0"];
    }
    
}




+(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    
    
    return result;
    
}

@end
