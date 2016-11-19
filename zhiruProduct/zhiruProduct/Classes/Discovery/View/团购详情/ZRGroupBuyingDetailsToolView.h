//
//  ZRGroupBuyingDetailsToolView.h
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZRGroupBuyingDetailsToolViewDelegate <NSObject>
/**
 *  立即购买
 */
- (void)buyImmediate;

@end

@interface ZRGroupBuyingDetailsToolView : UIView

@property (nonatomic, weak) id<ZRGroupBuyingDetailsToolViewDelegate> delegate;

@property (nonatomic, copy) NSString *nowPrice;
@property (nonatomic, copy) NSString *originalPrice;

@end
