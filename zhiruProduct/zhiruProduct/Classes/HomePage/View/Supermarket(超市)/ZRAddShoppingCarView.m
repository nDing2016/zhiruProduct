//
//  ZRAddShoppingCarView.m
//  zhiruProduct
//
//  Created by nanding on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAddShoppingCarView.h"
#import "ZRSupermarketHomeObj.h"
#import "ZRShoppingCarView.h"
#import "ZRSupermarketGoodsListModel.h"
#import "ZROrderingMenuModel.h"

#define kToolHeight           (40*SCREEN_HEIGHT/667)


#define buyWidth                    (75*SCREEN_WIDTH/375)
#define addWidth                    (100*SCREEN_WIDTH/375)


@interface ZRAddShoppingCarView ()



//灰色蒙版
@property (nonatomic, strong) UIView *modelView;

@property (nonatomic, strong) ZRShoppingCarView *shoppingCarView;


//选好了
@property (nonatomic, strong) UIButton *selectBtn;

//超市加入购物车
@property (nonatomic, strong) UIButton *addToCarBtn;

@end

@implementation ZRAddShoppingCarView
#pragma mark - 懒加载
-(UILabel *)redLabel
{
    if (!_redLabel) {
        //添加小红点
        _redLabel = [[UILabel alloc] init];
        _redLabel.backgroundColor = [UIColor redColor];
        _redLabel.clipsToBounds = YES;
        _redLabel.textColor = [UIColor whiteColor];
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.font = [UIFont systemFontOfSize:10];
        
    }
    return _redLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.shoppingCatBtn = [[UIButton alloc] init];
        [self.shoppingCatBtn setImage:ZRImage(@"supermarket_shoppingCar") forState:UIControlStateNormal];
        [self addSubview:self.shoppingCatBtn];
        
        
        //隐藏红点
        [self addSubview:self.redLabel];
        self.redLabel.hidden = YES;
        
        
        //添加选好了按钮
        
        //[self addSubview:self.selectBtn];
        
        
        //接收通知---加
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(supermarketProductNoti:) name:@"SuperMarketProdectAdd" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(supermarketProductNoti:) name:@"WaimaiProdectAdd" object:nil];
        
        
        //接收通知---减
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(supermarketProductMinusNoti:) name:@"SuperMarketProdectMinus" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(supermarketProductMinusNoti:) name:@"WaimaiProdectMinus" object:nil];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCarReloadData:) name:@"ShoppingCarReloadData" object:nil];
        
        //判断是否显示购物车详情
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShoppingCar:)];
        [self addGestureRecognizer:tap];
        
        
        
        
    }
    return self;
}


-(void)setViewTag:(NSInteger)viewTag
{
    _viewTag = viewTag;
    self.tag = _viewTag;
    
    if (self.tag == kSupermarketShoppingCar_Tag) {
        //添加到购物车按钮
        [self addSubview:self.addToCarBtn];

        if ([ZRSupermarketHomeObj shareInstance].allNumber>0) {
            self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].allNumber];
            self.redLabel.hidden = NO;
        }
        
    }else if (self.tag == kWaimaiShoppingCar_Tag){
        if ([ZRSupermarketHomeObj shareInstance].totalNumber>0) {
            self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].totalNumber];
            self.redLabel.hidden = NO;
        }
        
    }

    
}

#pragma mark - 懒加载

-(UIView *)modelView
{
    if (!_modelView) {
        //添加蒙版
        _modelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kToolHeight)];
        _modelView.backgroundColor = [UIColor blackColor];
        _modelView.alpha = 0.7;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modelViewTap:)];
        [_modelView addGestureRecognizer:tap];
        
    }
    return _modelView;
}




-(ZRShoppingCarView *)shoppingCarView
{
    if (!_shoppingCarView) {
        //购物车详情页面
        _shoppingCarView = [[ZRShoppingCarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-kToolHeight, SCREEN_WIDTH, 0)];
        _shoppingCarView.Tag = self.tag;
        if (self.tag == kSupermarketShoppingCar_Tag) {
            _shoppingCarView.allArray = [ZRSupermarketHomeObj shareInstance].allProductsArray;
            
        }else if (self.tag == kWaimaiShoppingCar_Tag){
            _shoppingCarView.allArray = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
            
        }
        
    }
    return _shoppingCarView;
}


/**
 *  选好了
 */
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        
        CGSize priceSize = [NSString getSize:[NSString stringWithFormat:@"%.2f",[ZRSupermarketHomeObj shareInstance].allPrice] strFont:CustomFont(16) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_shoppingCatBtn.frame)+10+priceSize.width+10, 0, addWidth, kToolHeight)];
        _selectBtn.backgroundColor = RGBCOLOR(255, 82, 82);
        [_selectBtn setTitle:@"选好了" forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _selectBtn;
}


-(UIButton *)addToCarBtn
{
    if (!_addToCarBtn) {
        _addToCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-addWidth, 0, addWidth, kToolHeight)];
        _addToCarBtn.backgroundColor = RGBCOLOR(255, 82, 82);
        [_addToCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addToCarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addToCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addToCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_addToCarBtn addTarget:self action:@selector(addToCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToCarBtn;
}



#pragma mark - click methods
/**
 *  选好了
 */
- (void)selectBtnClick:(UIButton *)sender
{
    
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        [AlertText showAndText:@"用户未登录"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:@"1"];
        return;
    }
    
      //ZROrderingMenuModel
//   NSArray * array = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
    if(self.tag == kSupermarketShoppingCar_Tag) {
         [[NSNotificationCenter defaultCenter] postNotificationName:kShoppingCarSelectFinished_Noti object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:ZRNotificationOrderClick object:nil];
    }
   
    

}

/**
 *  加入购物车
 */
- (void)addToCarBtnClick:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSupermarketAddToShoppingCar_Noti object:nil];
}


#pragma mark - 通知
- (void)supermarketProductNoti:(NSNotification *)noti
{
    //购物车总数加1
    self.redLabel.text = [NSString stringWithFormat:@"%ld",[self.redLabel.text integerValue]+1];
    
    //总钱数增加
    
    [self setNeedsDisplay];
}

- (void)supermarketProductMinusNoti:(NSNotification *)noti
{
    //购物车总数减1
    if ([self.redLabel.text integerValue]>1) {
       self.redLabel.text = [NSString stringWithFormat:@"%ld",[self.redLabel.text integerValue]-1];
    }else{
        self.redLabel.hidden = YES;
    }
    
    
    //总钱数减少
    
    [self setNeedsDisplay];
}



- (void)shoppingCarReloadData:(NSNotification *)noti
{
    WS(ws)
    if (self.tag == kWaimaiShoppingCar_Tag) {
        if ([ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count>0) {
            [UIView animateWithDuration:1 animations:^{
                CGFloat toolHeight = 30*SCREEN_HEIGHT/667;
                CGFloat cellHeight = 44*SCREEN_HEIGHT/667;
                if (toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count>SCREEN_HEIGHT/2-kToolHeight) {
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-kToolHeight);
                }else{
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight-(toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count), SCREEN_WIDTH, toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count);
                }
                
                [ws.shoppingCarView.tableView reloadData];
                
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [self modelViewTap:nil];
        }

        
    }else if (self.tag == kSupermarketShoppingCar_Tag){
        if ([ZRSupermarketHomeObj shareInstance].allProductsArray.count>0) {
            [UIView animateWithDuration:1 animations:^{
                CGFloat toolHeight = 30*SCREEN_HEIGHT/667;
                CGFloat cellHeight = 44*SCREEN_HEIGHT/667;
                if (toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count>SCREEN_HEIGHT/2-kToolHeight) {
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-kToolHeight);
                }else{
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight-(toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].allProductsArray.count), SCREEN_WIDTH, toolHeight+cellHeight*[ZRSupermarketHomeObj shareInstance].allProductsArray.count);
                }

                
                [ws.shoppingCarView.tableView reloadData];
                
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [self modelViewTap:nil];
        }

        
    }
    
    
}



#pragma mark - 布局
-(void)layoutSubviews
{
    [_shoppingCatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
        make.width.equalTo(@28);
        
        
    }];
    
    NSString *str;
    if (self.tag == kSupermarketShoppingCar_Tag) {
       str = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].allNumber];
    }else if (self.tag == kWaimaiShoppingCar_Tag){
       str = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].totalNumber];
    }
    
    CGSize sizeStr = [NSString getSize:str strFont:[UIFont systemFontOfSize:10] maxSize:self.bounds.size];
    [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shoppingCatBtn).with.offset(28-sizeStr.height/2);
        make.top.equalTo(@5);
        make.width.equalTo(@(sizeStr.height));
        make.height.equalTo(@(sizeStr.height));
        
    }];
    self.redLabel.layer.cornerRadius = sizeStr.height/2;
    
}

//添加
-(void)setGoodsListModel:(ZRSupermarketGoodsListModel *)goodsListModel
{
    _goodsListModel = goodsListModel;
    
    [ZRSupermarketHomeObj shareInstance].allNumber++;
    
    //显示价格
    _price = [goodsListModel.now_price floatValue] + [ZRSupermarketHomeObj shareInstance].allPrice;
    [ZRSupermarketHomeObj shareInstance].allPrice = _price;
    
    
    [self setNeedsDisplay];
    
    
    if ([ZRSupermarketHomeObj shareInstance].allNumber>0) {
        self.redLabel.hidden = NO;
        self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].allNumber];
    }

    
}


-(void)setOrderingMenuModel:(ZROrderingMenuModel *)orderingMenuModel
{
    _orderingMenuModel = orderingMenuModel;
    
    [ZRSupermarketHomeObj shareInstance].totalNumber++;
    
    //显示价格
    _price = [_orderingMenuModel.unit_price floatValue] + [ZRSupermarketHomeObj shareInstance].totalPrice;
    [ZRSupermarketHomeObj shareInstance].totalPrice = _price;
    
    
    [self setNeedsDisplay];
    
    
    if ([ZRSupermarketHomeObj shareInstance].totalNumber>0) {
        self.redLabel.hidden = NO;
        self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].totalNumber];
    }
    
}




-(void)drawRect:(CGRect)rect
{
    //购物车
    //[self drawImage:ZRImage(@"supermarket_shoppingCar") Rect:CGRectMake(10, 12, 28, self.height-20)];
    
    if (self.tag == kSupermarketShoppingCar_Tag) {
        CGSize size = [NSString getSize:[NSString stringWithFormat:@"$%.2f",[ZRSupermarketHomeObj shareInstance].allPrice] strFont:[UIFont systemFontOfSize:16] maxSize:self.bounds.size];
        CGFloat x = CGRectGetMaxX(_shoppingCatBtn.frame)+10;
        CGFloat y = (self.height-size.height)/2;
        
        //价格
        CGSize priceSize = [self drawWithStr:[NSString stringWithFormat:@"$%.2f",[ZRSupermarketHomeObj shareInstance].allPrice] Font:[UIFont systemFontOfSize:16] Color:[UIColor whiteColor] Point:CGPointMake(x, y)];
        
        //竖线
        [self drawLineStartPoint:CGPointMake(x+priceSize.width+5, y-4) endPoint:CGPointMake(x+priceSize.width+5, y+priceSize.height+4) Color:[UIColor whiteColor]];
        
        
        
        
        
        
        //另需配送费$2
        //NSString *peisongfei = [NSString stringWithFormat:@"另需配送费%@",]
//        if (iPhone5) {
//            [self drawWithStr:@"另需配送费$2" Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(x+priceSize.width+5+5, y)];
//        }else{
//            [self drawWithStr:@"另需配送费$2" Font:CustomFont(16) Color:[UIColor whiteColor] Point:CGPointMake(x+priceSize.width+5+5, y)];
//        }
        
        
        //还差$20起送
        CGSize size2;
        if ([ZRSupermarketHomeObj shareInstance].allPrice <[self.leftStr floatValue]) {
            //还差。。。起送
            self.selectBtn.hidden = YES;
            CGFloat cha = [self.leftStr floatValue]-[ZRSupermarketHomeObj shareInstance].allPrice;
            if (iPhone5) {
                size2 = [NSString getSize:[NSString stringWithFormat:@"还差$%.2f起送",cha] strFont:CustomFont(14) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
                [self drawWithStr:[NSString stringWithFormat:@"还差$%.2f起送",cha] Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(x+priceSize.width+5+5, y)];
            }else{
                size2 = [NSString getSize:[NSString stringWithFormat:@"还差$%.2f起送",cha] strFont:CustomFont(16) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
                [self drawWithStr:[NSString stringWithFormat:@"还差$%.2f起送",cha] Font:CustomFont(16) Color:[UIColor whiteColor] Point:CGPointMake(x+priceSize.width+5+5, y)];
            }
            
        }else{
            //        //选好了
            self.selectBtn.frame = CGRectMake(CGRectGetMinX(self.addToCarBtn.frame)-20-addWidth, 0, addWidth, self.height);
            [self addSubview:self.selectBtn];

            self.selectBtn.hidden = NO;
        }
        
        
        
        
        //选好了
        //[self setUpFinishSelectBtn:CGRectMake(SCREEN_WIDTH-100, 0, 100, self.height)];
        
        
    }else if (self.tag == kWaimaiShoppingCar_Tag){
        CGSize size = [NSString getSize:[NSString stringWithFormat:@"%ld",(long)[ZRSupermarketHomeObj shareInstance].totalPrice] strFont:[UIFont systemFontOfSize:16] maxSize:self.bounds.size];
        CGFloat x = CGRectGetMaxX(_shoppingCatBtn.frame)+10;
        CGFloat y = (40-size.height)/2;
        
        [self drawWithStr:[NSString stringWithFormat:@"$%.2f",[ZRSupermarketHomeObj shareInstance].totalPrice] Font:[UIFont systemFontOfSize:16] Color:[UIColor whiteColor] Point:CGPointMake(x, y)];
        
        if ([ZRSupermarketHomeObj shareInstance].totalPrice > 0) {
            //        //选好了
            self.selectBtn.frame = CGRectMake(SCREEN_WIDTH-addWidth, 0, addWidth, self.height);
            [self addSubview:self.selectBtn];

            self.selectBtn.hidden = NO;
            
        }
        
    }
    
}

//减少
- (void)minusWithGoods:(NSObject *)goods;
{
    if (self.tag == kWaimaiShoppingCar_Tag) {
        ZROrderingMenuModel *menu = (ZROrderingMenuModel *)goods;
        [ZRSupermarketHomeObj shareInstance].totalNumber--;
        
        //显示价格
        _price = [ZRSupermarketHomeObj shareInstance].totalPrice - [menu.unit_price floatValue];
        [ZRSupermarketHomeObj shareInstance].totalPrice = _price;
        
        
        [self setNeedsDisplay];
        
        if ([ZRSupermarketHomeObj shareInstance].totalNumber<1) {
            self.redLabel.hidden = YES;
            
        }else{
            NSInteger num = [ZRSupermarketHomeObj shareInstance].totalNumber;
            self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
        }

    }else if (self.tag == kSupermarketShoppingCar_Tag){
        ZRSupermarketGoodsListModel *goodList = (ZRSupermarketGoodsListModel *)goods;
        [ZRSupermarketHomeObj shareInstance].allNumber--;
        
        //显示价格
        _price = [ZRSupermarketHomeObj shareInstance].allPrice - [goodList.now_price floatValue];
        [ZRSupermarketHomeObj shareInstance].allPrice = _price;
        
        
        [self setNeedsDisplay];
        
        if ([ZRSupermarketHomeObj shareInstance].allNumber<1) {
            self.redLabel.hidden = YES;
            
        }else{
            NSInteger num = [ZRSupermarketHomeObj shareInstance].allNumber;
            self.redLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
        }

        
    }
    
    

}


#pragma mark - private methods
//- (void)setUpFinishSelectBtn:(CGRect)btnRect
//{
//    UIButton *selectedBtn = [[UIButton alloc] initWithFrame:btnRect];
//    selectedBtn.backgroundColor = RGBCOLOR(255, 82, 82);
//    [selectedBtn setTitle:@"选好了" forState:UIControlStateNormal];
//    [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    selectedBtn.titleLabel.font = CustomFont(15);
//    selectedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:selectedBtn];
//}


#pragma mark - 点击购物车手势
- (void)tapShoppingCar:(UITapGestureRecognizer *)gesture
{
    WS(ws)
    CGFloat toolHeight = 30*SCREEN_HEIGHT/667;
    CGFloat cellHeight = 44*SCREEN_HEIGHT/667;
    
    
    if (self.tag == kSupermarketShoppingCar_Tag) {
        //超市购物车
        NSInteger num = [ZRSupermarketHomeObj shareInstance].allProductsArray.count;
        if (num > 0) {
            UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
            [myWindow addSubview:self.modelView];
            [myWindow addSubview:self.shoppingCarView];
            [self.shoppingCarView.tableView reloadData];
            //弹出购物车详情页面
            [UIView animateWithDuration:1 animations:^{
                if (toolHeight+cellHeight*num+kToolHeight>SCREEN_HEIGHT/2) {
                   ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-kToolHeight);
                }else{
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight-(toolHeight+cellHeight*num), SCREEN_WIDTH, toolHeight+cellHeight*num);
                }
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
 
    }else if (self.tag == kWaimaiShoppingCar_Tag){
       //外卖购物车
        NSInteger num = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray.count;
        if (num>0) {
            UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
            [myWindow addSubview:self.modelView];
            [myWindow addSubview:self.shoppingCarView];
            [self.shoppingCarView.tableView reloadData];
            //弹出购物车详情页面
            [UIView animateWithDuration:1 animations:^{
//                self.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight-(toolHeight+cellHeight*num), SCREEN_WIDTH, toolHeight+cellHeight*num);
                if (toolHeight+cellHeight*num+kToolHeight>SCREEN_HEIGHT/2) {
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-kToolHeight);
                }else{
                    ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight-(toolHeight+cellHeight*num), SCREEN_WIDTH, toolHeight+cellHeight*num);
                }

            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    
    
    
    
}

/**
 *  蒙板点击事件
 *
 *  @param gesture
 */
- (void)modelViewTap:(UITapGestureRecognizer *)gesture
{
    WS(ws)
    [UIView animateWithDuration:1 animations:^{
        //收回购物车详情页面
        ws.shoppingCarView.frame = CGRectMake(0, SCREEN_HEIGHT-kToolHeight, SCREEN_WIDTH, 0);
        
        
    } completion:^(BOOL finished) {
        [ws.shoppingCarView removeFromSuperview];
        //蒙板消失
        [ws.modelView removeFromSuperview];
    }];
}



///**
// *  选好了点击事件
// */
//- (void)selectedBtnClick:(UIButton *)sender
//{
//    //将数据模型传到下一个页面
//    
//    
//    
//    
//    
//    
//    
//}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SuperMarketProdectAdd" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WaimaiProdectAdd" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SuperMarketProdectMinus" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WaimaiProdectMinus" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShoppingCarReloadData" object:nil];
}


@end
