//
//  ZRProductDetailCell.m
//  zhiruProduct
//
//  Created by nanding on 16/9/3.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProductDetailCell.h"
#import "ZRProductDetailModel.h"

@interface ZRProductDetailCell ()

@property (nonatomic, strong) NSIndexPath *idxPath;

@end

@implementation ZRProductDetailCell

-(void)setProductDetails:(ZRProductDetailModel *)productDetails
{
    _productDetails = productDetails;
    
    [self setNeedsDisplay];
    
}


+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellID = @"cellID";
    ZRProductDetailCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.idxPath = idxPath;
    
    return cell;
}


-(void)drawRect:(CGRect)rect
{
    
}


@end
