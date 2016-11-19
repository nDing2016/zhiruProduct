//
//  UIScrollView+ZRRefresh.m
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "UIScrollView+ZRRefresh.h"

@implementation UIScrollView (ZRRefresh)

-(void)startRefreshWithCallback:(RefreshCallback)callback
{
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:myClass refreshingAction:action];
      
     MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
         
         if (callback) {
             callback();
         }
         
         
         
     }];
    
    
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_animate_00%zd", i]];
        [idleImages addObject:image];
    }
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_00%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // Hide the status
    header.stateLabel.hidden = YES;
    
    self.mj_header = header;
    [self.mj_header beginRefreshing];// 设置普通状态的动画图片
    
}

-(void)startFooterRefreshWithCallback:(RefreshCallback)callback
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        
        if (callback) {
            callback();
        }
        
    }];
    
    
    // 设置文字
    [footer setTitle:@"点击获取更多" forState:MJRefreshStateIdle];
    
    
    
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    footer.stateLabel.textColor = RGBCOLOR(154, 154, 154);
    //footer.stateLabel.hidden = YES;
    self.mj_footer = footer;
    //[self.mj_footer beginRefreshing];
    
    
}


- (void)startFooterRefresh:(id)myClass Action:(SEL)action
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:myClass refreshingAction:action];
    
    
    // 设置文字
    [footer setTitle:@"点击获取更多" forState:MJRefreshStateIdle];
    
    
    
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    footer.stateLabel.textColor = RGBCOLOR(154, 154, 154);
    
    self.mj_footer = footer;
    
    
}




@end
