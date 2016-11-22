//
//  ZRShoppingCarCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarCell.h"
#import "ZRSupermarketHomeObj.h"

#import "ZRSupermarketGoodsListModel.h"
#import "ZROrderingMenuModel.h"

#define kCellHeight          (44*SCREEN_HEIGHT/667)

@interface ZRShoppingCarCell ()

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *minusBtn;

@property (nonatomic, assign) CGFloat price;//单价

@end

@implementation ZRShoppingCarCell

#pragma mark - 懒加载
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-22, (kCellHeight-22)/2, 22, 22)];
        [_addBtn setImage:ZRImage(@"supermarket_plus") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addBtn;
}



-(UIButton *)minusBtn
{
    if (!_minusBtn) {
        _minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-22-30-22, (kCellHeight-22)/2, 22, 22)];
        [_minusBtn setImage:ZRImage(@"supermarket_minus") forState:UIControlStateNormal];
        [_minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}


#pragma mark - set 方法

-(void)setModel:(NSObject *)model
{
    _model = model;
    
    //添加加减按钮
    [self addSubview:self.addBtn];
    [self addSubview:self.minusBtn];
    
    [self setNeedsDisplay];
}



#pragma mark - init methods
+(instancetype)cellWithTable:(UITableView *)table IndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellID = @"cellID";
    ZRShoppingCarCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
    
}



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    NSString *name;
    NSString *price;
    if (self.viewTag == kWaimaiShoppingCar_Tag) {
        ZROrderingMenuModel *menu = (ZROrderingMenuModel *)_model;
        name = menu.name;
        price = [NSString stringWithFormat:@"%@",menu.unit_price];;
        
    }else if (self.viewTag == kSupermarketShoppingCar_Tag){
        ZRSupermarketGoodsListModel *goodsList = (ZRSupermarketGoodsListModel *)_model;
        name = goodsList.goods_name;
        price = [NSString stringWithFormat:@"%.2f",[goodsList.now_price floatValue]];
    }
    

    
    
    //数量
    NSString *numStr = [NSString stringWithFormat:@"%ld",(long)self.num];
    CGSize numSize = [NSString getSize:numStr strFont:[UIFont systemFontOfSize:14] maxSize:self.frame.size];
    [self drawWithStr:numStr Font:[UIFont systemFontOfSize:14] Color:[UIColor blackColor] Point:CGPointMake(CGRectGetMaxX(self.minusBtn.frame)+(30-numSize.width)/2, (kCellHeight-numSize.height)/2)];
    
    
    
    //价格=单价*数量
    _price = [price floatValue];
    NSInteger num = [numStr integerValue];
    NSString *allProce = [NSString stringWithFormat:@"$%.2f",(_price *num)];
    CGSize allPriceSize = [NSString getSize:allProce strFont:[UIFont systemFontOfSize:12] maxSize:self.frame.size];
    [self drawWithStr:allProce Font:[UIFont systemFontOfSize:12] Color:[UIColor redColor] Point:CGPointMake(CGRectGetMinX(self.minusBtn.frame)-10-allPriceSize.width, (kCellHeight-allPriceSize.height)/2)];
    
    //商品名称
    CGFloat X = CGRectGetMinX(self.minusBtn.frame)-10-allPriceSize.width;
    CGSize strSize = [NSString getSize:name strFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(SCREEN_WIDTH-X, self.height)];
    [self drawWithStr:name Font:[UIFont systemFontOfSize:12] Color:[UIColor blackColor] Point:CGPointMake(15, (self.height-strSize.height)/2) Size:CGSizeMake(SCREEN_WIDTH-X, strSize.height)];
    
    
    
}


#pragma mark - layoutsubview
//-(void)layoutSubviews
//{
//    
//    CGFloat x = SCREEN_WIDTH-15-20;
//    CGFloat y = (kCellHeight-20)/2;
//    self.addBtn.frame = CGRectMake(x, y, 20, 20);
//    
//    self.minusBtn.frame = CGRectMake(x-20-20, y, 20, 20);
//    
//    
//
//    
//}


#pragma mark - click methods
- (void)addBtnClick:(UIButton *)sender
{
    //本地加1,本地总价增加
    self.num++;
    [self setNeedsDisplay];

    NSMutableArray *allProductsArr;
    if (self.viewTag == kWaimaiShoppingCar_Tag) {
        //model数据更新
        [ZRSupermarketHomeObj shareInstance].totalNumber++;
        [ZRSupermarketHomeObj shareInstance].totalPrice = [ZRSupermarketHomeObj shareInstance].totalPrice+_price;
        
        allProductsArr = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
        
        NSMutableArray *productsArr = [allProductsArr objectAtIndex:self.idxPath.row];
        [productsArr addObject:productsArr[0]];
        
        
        //同步到商品列表、购物车加1、购物车总价增加
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WaimaiProdectAdd" object:productsArr[0]];
        
    }else if (self.viewTag == kSupermarketShoppingCar_Tag){
        //model数据更新
        [ZRSupermarketHomeObj shareInstance].allNumber++;
        [ZRSupermarketHomeObj shareInstance].allPrice = [ZRSupermarketHomeObj shareInstance].allPrice+_price;
        
        allProductsArr = [ZRSupermarketHomeObj shareInstance].allProductsArray;
        
        NSMutableArray *productsArr = [allProductsArr objectAtIndex:self.idxPath.row];
        
        [productsArr addObject:productsArr[0]];
        
        //同步到商品列表、购物车加1、购物车总价增加
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuperMarketProdectAdd" object:productsArr[0]];
        
    }

    
}

- (void)minusBtnClick:(UIButton *)sender
{
    if (self.viewTag == kSupermarketShoppingCar_Tag) {
        //model数据更新
        [ZRSupermarketHomeObj shareInstance].allNumber--;
        [ZRSupermarketHomeObj shareInstance].allPrice = [ZRSupermarketHomeObj shareInstance].allPrice-_price;
        
        NSMutableArray *allProductsArr = [ZRSupermarketHomeObj shareInstance].allProductsArray;
        
        NSMutableArray *productsArr = [allProductsArr objectAtIndex:self.idxPath.row];
        if (self.num > 1) {
            //本地减1，本地总价减少
            self.num--;
            [self setNeedsDisplay];
            [productsArr removeLastObject];
            
        }else{
            //==1的时候直接删除cell
            [[ZRSupermarketHomeObj shareInstance].allProductsArray removeObjectAtIndex:self.idxPath.row];
            //刷新tableView
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingCarReloadData" object:nil];
            
            
        }
        //同步到商品列表、购物车减1、购物车总价减少
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuperMarketProdectMinus" object:productsArr[0]];

        
    }else if (self.viewTag == kWaimaiShoppingCar_Tag){
        
        //model数据更新
        
        [ZRSupermarketHomeObj shareInstance].totalNumber--;
        [ZRSupermarketHomeObj shareInstance].totalPrice = [ZRSupermarketHomeObj shareInstance].totalPrice-_price;
        
        NSMutableArray *allProductsArr = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
        
        NSMutableArray *productsArr = [allProductsArr objectAtIndex:self.idxPath.row];
        if (self.num > 1) {
            //本地减1，本地总价减少
            self.num--;
            [self setNeedsDisplay];
            [productsArr removeLastObject];
            
            //[[ZRSupermarketHomeObj shareInstance] replaceProducts:productsArr IndexPath:self.idxPath];
            [[ZRSupermarketHomeObj shareInstance] replaceProducts:productsArr withObject:productsArr[0]];
            
        }else{
            //==1的时候直接删除cell
            [[ZRSupermarketHomeObj shareInstance].selectedFoodsArray removeObjectAtIndex:self.idxPath.row];
            
            //刷新tableView
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingCarReloadData" object:nil];
            
        }
        //同步到商品列表、购物车减1、购物车总价减少
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WaimaiProdectMinus" object:productsArr[0]];

        
    }
    
    
    
    
    
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
