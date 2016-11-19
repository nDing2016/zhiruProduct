//
//  AlertText.h
//  zhiruProduct
//
//  Created by pj on 16/9/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertText : UIView

- (instancetype)initAndText:(NSString *)string;
+ (void)showAndText:(NSString *)string;
@end
