//
//  ZRSuperOrderFrame.m
//  zhiruProduct
//
//  Created by nanding on 16/11/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSuperOrderFrame.h"
#import "ZRSuperOrderDetailModel.h"

@implementation ZRSuperOrderFrame


-(void)setSuperDetailsModel:(ZRSuperDetailsModel *)superDetailsModel
{
    _superDetailsModel = superDetailsModel;
    [self goodsListcellHight];
}


- (void)goodsListcellHight
{
    WS(ws)
    __block CGFloat hei=0;
    [self.superDetailsModel.goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZRSuperOrderDetailModel *model = obj;
        CGSize goodsSize = [NSString getSize:model.goods_name strFont:CustomFont(14) maxSize:CGSizeMake((260*SCREEN_WIDTH/375-15), SCREEN_HEIGHT)];
        hei = hei+goodsSize.height;
        
        if (idx == ws.superDetailsModel.goodsList.count-1) {
            _cellHeight = hei;
        }
        
    }];
    
}


@end
