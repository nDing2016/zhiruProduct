//
//  ZRCheckReviewPictureView.h
//  zhiruProduct
//
//  Created by nanding on 16/12/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRCheckReviewPictureView;
@protocol ZRCheckReviewPicViewDelegate <NSObject>

- (void)dismissView:(ZRCheckReviewPictureView *)view;

@end

@interface ZRCheckReviewPictureView : UIView

@property (nonatomic, strong) NSArray *picturesArray;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, weak) id<ZRCheckReviewPicViewDelegate> delegate;

@end
