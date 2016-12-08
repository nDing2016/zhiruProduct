//
//  ZRSupermarketHomeObj.m
//  zhiruProduct
//
//  Created by nanding on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketHomeObj.h"
#import "ZROrderingMenuModel.h"
@implementation ZRSupermarketHomeObj

+(instancetype)shareInstance
{
    static ZRSupermarketHomeObj *obj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        obj = [[ZRSupermarketHomeObj alloc] init];

    });
    return obj;
}


-(NSMutableDictionary *)shoppingCarDic
{
    if (!_shoppingCarDic) {
        _shoppingCarDic = [NSMutableDictionary dictionary];
    }
    return _shoppingCarDic;
}


-(NSMutableArray *)allProductsArray
{
    if (!_allProductsArray) {
        
        _allProductsArray = [NSMutableArray array];
    }
    return _allProductsArray;
}


-(NSMutableArray *)selectedFoodsArray
{
    if (!_selectedFoodsArray) {
        _selectedFoodsArray = [NSMutableArray array];
    }
    return _selectedFoodsArray;
}

-(CGFloat)getPrductsMoneyCount{
    CGFloat unit_price= 0;
    for (NSArray * arr  in self.selectedFoodsArray) {
        
        ZROrderingMenuModel * model = arr[0];
        unit_price += [model.unit_price floatValue] * arr.count;
    }
    return unit_price;
}

-(isFirst)isfirst
{
    if (!_isfirst) {
     
    }
    return _isfirst;
}

/**
 *  添加
 *
 */
-(isFirst)comparewithObject:(NSObject *)object productArr:(NSArray *)product
{
    if (self.selectedFoodsArray.count>0) {
        __block BOOL isAdded = NO;
        [self.selectedFoodsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *productsArr = obj;
            if ([productsArr[0] isEqual:object]) {
                [productsArr addObject:[productsArr lastObject]];
                isAdded = YES;
                *stop = YES;
            }
        }];
        
        if (isAdded == YES) {
            return Seledted;
        }else{
            
            NSMutableArray *productsArr = [NSMutableArray arrayWithObject:product];
            [self.selectedFoodsArray addObject:productsArr];
            
            return NonSelected;
        }
        
        
    }else{
        NSMutableArray *productsArr = [NSMutableArray arrayWithObject:product];
        [self.selectedFoodsArray addObject:productsArr];
        return NonSelected;
    }
    
    
    
    
}

//获取某行的添加内容
-(NSMutableArray *)getProductsArr:(NSObject *)model
{
    __block NSMutableArray *productsArr;
    [self.selectedFoodsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[0] isEqual:model]) {
            productsArr = obj;
        }
        
    }];
    
    return productsArr;
    
    
    
}


//替换某行的内容
-(void)replaceProducts:(NSMutableArray *)products withObject:(NSObject *)object
{
    
   
    
    __block NSInteger index;
//    NSLog(@"%@",self.selectedFoodsArray);
    
//    for (NSArray *arr in self.selectedFoodsArray) {
//        if ([arr[0] isEqual:object]) {
//            index = [self.selectedFoodsArray indexOfObject:arr];
//            [self.selectedFoodsArray replaceObjectAtIndex:index withObject:products];
//            
//        }
//    }
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.selectedFoodsArray];
    
    [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = obj;
        ZROrderingMenuModel *model = arr[0];
        ZROrderingMenuModel *objectModel = (ZROrderingMenuModel *)object;
        if ([model.menu_id isEqualToString:objectModel.menu_id]) {
            index = idx;
            [self.selectedFoodsArray replaceObjectAtIndex:index withObject:products];
            *stop = YES;
        }
    }];
    
   
   
    
}


@end
