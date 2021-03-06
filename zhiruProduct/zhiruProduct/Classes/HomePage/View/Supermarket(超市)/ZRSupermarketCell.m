//
//  ZRSupermarketCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketCell.h"
#import "ZRSupermarketGoodsListModel.h"
#import "ZRSupermarketRequest.h"

@interface ZRSupermarketCell ()



@end

@implementation ZRSupermarketCell

//-(void)setListArr:(NSArray *)listArr
//{
//    _listArr = listArr;
//    
//    
//}

-(void)setTravelArr:(NSArray *)travelArr
{
    _travelArr = travelArr;
}

-(void)setCategoryTravelArr:(NSArray *)categoryTravelArr
{
    _categoryTravelArr = categoryTravelArr;
}


-(void)setGoodsList:(ZRSupermarketGoodsListModel *)goodsList
{
    _goodsList = goodsList;
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect
{
    if (_goodsList) {
        //商品图片
        CGRect rect;
        if (_cellIndex%2 == 0) {
            rect = CGRectMake(15*SCREEN_WIDTH/375, 10, self.width-22.5, self.width-22.5);
        }else{
            rect = CGRectMake(7.5*SCREEN_WIDTH/375, 10, self.width-22.5, self.width-22.5);
        }
//        [self drawImage:self.img Rect:rect];
        
        //context
        //商品名
        CGSize nameSize = [NSString getSize:@"综合粉丝" strFont:CustomFont(12) maxSize:CGSizeMake(self.width-22.5, self.height)];
        
        [self setUpProductName:_goodsList.goods_name AndRect:CGRectMake(rect.origin.x, rect.size.height+15, self.width-22.5, nameSize.height+5)];
        
        
        //现价
        NSString *nowPrice = [NSString stringWithFormat:@"$%@",_goodsList.now_price];
        CGSize nowPriceSize = [self drawWithStr:nowPrice Font:[UIFont systemFontOfSize:12] Color:[UIColor redColor] Point:CGPointMake(rect.origin.x, CGRectGetMaxY(rect)+nameSize.height+10)];
        //原价
        NSString *oldPri = [NSString stringWithFormat:@"原价$%@",_goodsList.old_price];
        CGSize size = [self drawWithStr:oldPri Font:[UIFont systemFontOfSize:12] Color:[UIColor grayColor] Point:CGPointMake(rect.origin.x+nowPriceSize.width+15, CGRectGetMaxY(rect)+nameSize.height+10)];
        //line
//        [self drawLineStartPoint:CGPointMake(rect.origin.x+nowPriceSize.width+13,  CGRectGetMaxY(rect)+nameSize.height+10+size.height/2) endPoint:CGPointMake(rect.origin.x+nowPriceSize.width+size.width+17, CGRectGetMaxY(rect)+nameSize.height+10+size.height/2) Color:[UIColor redColor]];
        
        
        //商品重量千克
        NSString *weightStr = [NSString stringWithFormat:@"%@kg",_goodsList.weight];
        [self drawWithStr:weightStr Font:CustomFont(12) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(rect.origin.x, CGRectGetMaxY(rect)+nameSize.height+10+size.height+5)];
        
    }else if (_travelArr){
        [self drawImage:_travelArr[0] Rect:CGRectMake((self.width-60)/2, (self.height-60)/2-10, 60, 60)];
        CGSize size = [NSString getSize:_travelArr[1] strFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(SCREEN_WIDTH, 40)];
        UIColor *color;
        if ([_travelArr[2] isEqualToString:@"1"]) {
            color = [UIColor blueColor];
        }else{
            color = [UIColor blackColor];
        }
        [self drawWithStr:_travelArr[1] Font:[UIFont systemFontOfSize:16] Color:color Point:CGPointMake((self.width-size.width)/2, (self.height-60)/2-10+60+5)];
    }else if (_categoryTravelArr){
        //边框
//        [self drawRectangleWithPoint1:CGPointMake(15, 15) Point2:CGPointMake(self.width-22.5+15, 15) Point3:CGPointMake(self.width-22.5+15, self.height) Point4:CGPointMake(15, self.height) Color:173/255 G:173/255 B:173/255 Alpha:1];
        
        CGRect rect;
        if (_cellIndex%2 == 0) {
            rect = CGRectMake(15, 15, self.width-22.5, self.height*3/5);
        }else{
            rect = CGRectMake(7.5, 15, self.width-22.5, self.height*3/5);
        }
        [self drawImage:_categoryTravelArr[0] Rect:rect];
        
        CGSize strSize = [NSString getSize:_categoryTravelArr[1] strFont:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(self.width-22.5, self.height)];
        [self drawWithStr:_categoryTravelArr[1] Font:[UIFont systemFontOfSize:10] Color:[UIColor grayColor] Point:CGPointMake(15, self.height*3/5+5+15) Size:strSize];
        
        [self drawWithStr:_categoryTravelArr[2] Font:[UIFont systemFontOfSize:10] Color:[UIColor redColor] Point:CGPointMake(15, 15+rect.size.height+5+strSize.height+5)];
        
        CGSize strSize2 = [NSString getSize:_categoryTravelArr[3] strFont:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(SCREEN_WIDTH, 40)];
        [self drawWithStr:_categoryTravelArr[3] Font:[UIFont systemFontOfSize:10] Color:[UIColor grayColor] Point:CGPointMake(self.width-22.5+15-10-strSize2.width, 15+rect.size.height+5+strSize.height+5)];
        
    }
    
}


- (void)setUpProductName:(NSString *)name AndRect:(CGRect)rect
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:rect];
    nameLabel.text = name;
    nameLabel.textColor = RGBCOLOR(85, 85, 85);
    nameLabel.font = CustomFont(12);
    [self.contentView addSubview:nameLabel];
}


//- (void)setUpShoppingCar:(CGRect)rect
//{
//    _shoppingCar = [MyControl createButtonWithFrame:rect ImageName:@"superCar" Target:self Action:@selector(shoppingCarClick:) Title:nil];
//    [self.contentView addSubview:_shoppingCar];
//}

/**
 *  加入购物车
 */
//- (void)shoppingCarClick:(UIButton *)sender
//{
//    //网络请求
////    [ZRSupermarketRequest requestAddToShoppingCarWithGoodsId:_goodsList.goods_id WithSupermarketId:_supermarketID Callback:^(NSString *codeStr, NSString *message, NSError *error) {
////                
////        if (error == nil) {
////            if ([self.delegate respondsToSelector:@selector(addToShoppingCarWithCode:WithCell:)]) {
////                [self.delegate addToShoppingCarWithCode:codeStr WithCell:self];
////            }
////            
////        }
////        
////        
////    }];
//    
//    NSMutableArray *listArr = [NSMutableArray array];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:_goodsList.goods_id forKey:@"goodsId"];
//    [dic setObject:_supermarketID forKey:@"kaId"];
//    [dic setObject:@"1" forKey:@"num"];
//    [listArr addObject:dic];
//    
//    WS(ws)
//    [ZRSupermarketRequest requestAddKaShoppingCartWithList:listArr Callback:^(NSString *codeStr, NSString *message, NSError *error) {
//        
//        if (error == nil) {
//            if ([ws.delegate respondsToSelector:@selector(addToShoppingCarWithCode:WithCell:)]) {
//                [ws.delegate addToShoppingCarWithCode:codeStr WithCell:ws];
//            }
//            
//        }
//        
//        
//    }];
//    
//    
//}

@end
