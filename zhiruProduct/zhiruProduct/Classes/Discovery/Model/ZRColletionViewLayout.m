//
//  ZRColletionViewLayout.m
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRColletionViewLayout.h"
#import "ZRCommodityListModel.h"

/** 每一行之间的间距 */
static const CGFloat RowMargin = 10;
/** 每一列之间的间距 */
static const CGFloat ColumnMargin = 10;
/** 每一列之间的间距 top, left, bottom, right */
static const UIEdgeInsets Insets = {13, 13, 13, 13};
/** 默认的列数 */
static const int ColumsCount = 2;

@interface ZRColletionViewLayout ()

/** 每一列的最大Y值 */
@property (nonatomic, strong) NSMutableArray *columnMaxYs;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

//存放所有cell的height
@property (nonatomic, strong) NSMutableArray *heightArray;


@end

@implementation ZRColletionViewLayout


#pragma mark - 懒加载
- (NSMutableArray *)columnMaxYs
{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}


-(NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


//-(void)setAttributeArray:(NSMutableArray *)attributeArray
//{
//    _attributeArray = attributeArray;
//    _heightArray = [NSMutableArray array];
//    //计算
//    for (int i=0; i<_attributeArray.count; i++) {
//        CGFloat hei;
//        // 水平方向上的总间距
//        CGFloat xMargin = Insets.left + Insets.right + (ColumsCount - 1) * ColumnMargin;
//        // cell的宽度
//        CGFloat w = (SCREEN_WIDTH - xMargin) / ColumsCount;
//        if (i>0) {
//            ZRCommodityListModel *model = [ZRCommodityListModel mj_objectWithKeyValues:_attributeArray[i]];
//            CGSize nameSize = [NSString getSize:model.commodityName strFont:CustomFont(13) maxSize:CGSizeMake(w, w)];
//            hei = w+5+nameSize.height+5+18+5+18+10;
//            [_heightArray addObject:@(hei)];
//        }
//    }
//    
//}


#pragma mark - Private methods
/**
 *  collectionView的contentSize
 *
 *  @return
 */
- (CGSize)collectionViewContentSize
{
    // 获取最长那一列的最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return CGSizeMake(0, destMaxY + Insets.bottom);
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 重置每一列的最大Y值
    [self.columnMaxYs removeAllObjects];
    for (NSUInteger i = 0; i<ColumsCount; i++) {
        [self.columnMaxYs addObject:@(Insets.top)];
    }
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  返回所有元素的布局属性
 *
 *  @param rect
 *
 *  @return
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 *  返回cell的布局属性
 *
 *  @param indexPath
 *
 *  @return
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算indexPath位置cell的布局属性 */
    
    // 水平方向上的总间距
    CGFloat xMargin = Insets.left + Insets.right + (ColumsCount - 1) * ColumnMargin;
    // cell的宽度
    CGFloat w = (SCREEN_WIDTH - xMargin) / ColumsCount;
    // cell的高度，测试数据，随机数
    CGFloat h;
    if (indexPath.item == 0) {
        //h = 120*SCREEN_HEIGHT/667;
        h = w;
    }else{
        
        //h = 180*SCREEN_HEIGHT/667;
        //h = 270*SCREEN_HEIGHT/667;
        //h = [self.heightArray[indexPath.item-1] floatValue];
        
        
        ZRCommodityListModel *model = [ZRCommodityListModel mj_objectWithKeyValues:_attributeArray[indexPath.item]];
        CGSize nameSize = [NSString getSize:model.commodityName strFont:CustomFont(13) maxSize:CGSizeMake(w-10, w)];
        h = w+5+nameSize.height+5+18+5+18+10;

        
        
    }
    
    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    
    // cell的x值
    CGFloat x = Insets.left + destColumn * (w + ColumnMargin);
    // cell的y值
    CGFloat y = destMaxY + RowMargin;
    // cell的frame
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

@end
