//
//  ZRCarteTableViewCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCarteTableViewCell.h"
#import "ZRSupermarketHomeObj.h"
#import "ZROrderingMenuModel.h"

#define CellWidth     (SCREEN_WIDTH-(90*ScreenWidth/375))
#define CellHeight    (70*ScreenHeight/667)


@interface ZRCarteTableViewCell ()

@property (nonatomic, strong) UIButton *minusBtn;

@property (nonatomic , assign) NSInteger count;

@end

@implementation ZRCarteTableViewCell


-(NSMutableArray *)productsArr
{
    if (!_productsArr) {
        _productsArr = [NSMutableArray array];
    }
    return _productsArr;
}

- (void)setMenuModel:(ZROrderingMenuModel *)menuModel {
    _menuModel = menuModel;
    
    NSURL * url = [NSURL URLWithString:menuModel.menu_img];
    [_orderingImg sd_setImageWithURL: url placeholderImage:ZRPlaceholderImage];
    
    _orderingName.text = menuModel.name;
    
    _orderingPrice.text = [NSString stringWithFormat:@"$ %.2lf",[menuModel.unit_price floatValue]];
    
    _orderingSoldNum.text = [NSString stringWithFormat:@"月售 %@",[menuModel.soldNum stringValue]];
    //注册通知
    //获取通知中心单例对象
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//    [center addObserver:self selector:@selector(notice:) name:ZRNotificationAdd object:nil];
}

#pragma mark - 通知
-(void)notice:(NSNotification*)sender{
    
    NSString * isAdd = sender.userInfo[@"isAdd"];
    if ([isAdd isEqualToString:@"1"]) {
        // 1 表示 add
        [self addBtnClick:self.addBtn];
    }else{
        [self minusBtnClick:self.minusBtn];
    }
    
}

-(void)setIdxPath:(NSIndexPath *)idxPath
{
    _idxPath = idxPath;
    //self.productsArr = [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
    self.countStr = nil;
    __block BOOL isShow = NO;
    WS(ws)
    [[ZRSupermarketHomeObj shareInstance].selectedFoodsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *productsArr = obj;
//        self.productsArr = productsArr;
        ZROrderingMenuModel *goodsList = productsArr[0];
//                if ([productsArr[0] isEqualToArray:indexArr]) {
//                    //显示减号
//                    self.minusBtn.frame = CGRectMake(CellWidth-15-22-30-22, CellHeight-10-22, 22, 22);
//                    [self addSubview:self.minusBtn];
//                    self.countStr = [NSString stringWithFormat:@"%lu", productsArr.count-1];
//                    isShow = YES;
//                    *stop = YES;
//                }
//
        if ([goodsList.menu_id isEqualToString:_menuModel.menu_id]) {
            ws.productsArr = [NSMutableArray arrayWithArray:productsArr];
            
            //显示减号
            //ws.minusBtn.frame = CGRectMake(CellWidth-15-22-30-22, CGRectGetMinY(self.addBtn.frame) + 15, 22, 22);
            //update by dingnan
            ws.minusBtn.frame = CGRectMake(CellWidth-15-22-30-22, CGRectGetMinY(self.addBtn.frame), 22, 22);
            
            [ws.contentView addSubview:ws.minusBtn];
//            self.count = productsArr.count;
            ws.countStr = [NSString stringWithFormat:@"%lu", (unsigned long)productsArr.count];
            isShow = YES;
            *stop = YES;
           
        }
        
    }];

    if (isShow == NO) {
        if (self.minusBtn) {
            [self.minusBtn removeFromSuperview];
        }
    }
    
    [self setNeedsDisplay];
}


#pragma mark - btnClick methods
- (void)minusBtnClick:(UIButton *)sender
{
    //判断是否收起减号
    if (self.productsArr.count>1) {
        //减1
        [self.productsArr removeLastObject];
        //[[ZRSupermarketHomeObj shareInstance] replaceProducts:self.productsArr IndexPath:self.idxPath];
        [[ZRSupermarketHomeObj shareInstance] replaceProducts:self.productsArr withObject:_menuModel];
        
    }else{
        //收起
        [[ZRSupermarketHomeObj shareInstance].selectedFoodsArray removeObject:self.productsArr];
        self.productsArr = nil;
        //收起动画
        [self animateWithMinusBtnOff];
        
    }
    
    
    [self setNeedsDisplay];
    
    //同步购物车数据
    if ([self.delegate respondsToSelector:@selector(minusFoods:ForIndexPath:)]) {
        [self.delegate minusFoods:self ForIndexPath:_idxPath];
    }
    
    
}



- (IBAction)addBtnClick:(id)sender {
    
    //1。判断该商品是否添加过（减号是否存在），如果未添加过则弹出减号，如果添加过则直接增加数量,更新数据
    if (self.productsArr.count>0) {
        [self.productsArr addObject:_menuModel];
        //[[ZRSupermarketHomeObj shareInstance] replaceProducts:self.productsArr IndexPath:self.idxPath];
        
        [[ZRSupermarketHomeObj shareInstance] replaceProducts:self.productsArr withObject:_menuModel];
        
    }else{
        self.minusBtn.hidden = NO;
        
        [self animateMinusBtn];
        self.productsArr = [NSMutableArray arrayWithObject:_menuModel];
        [[ZRSupermarketHomeObj shareInstance].selectedFoodsArray addObject:self.productsArr];
    }
    
    
    

    [self setNeedsDisplay];
    
    
    //2.添加购物车动画
    if ([self.delegate respondsToSelector:@selector(addFoods:ForIndexPath:)]) {
        [self.delegate addFoods:self ForIndexPath:_idxPath];
    }
   
    
    
    
}

#pragma mark - 懒加载
-(UIButton *)minusBtn
{
    if (!_minusBtn) {
//        _minusBtn = [[UIButton alloc] init];
//        [_minusBtn setImage:ZRImage(@"waimai_Minus") forState:UIControlStateNormal];
//        [_minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_minusBtn];
//        
//        [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (self.productsArr) {
//                make.right.equalTo(_addBtn).with.offset(-52);
//            }else{
//                make.right.equalTo(_addBtn.mas_right);
//            }
//            make.top.equalTo(_addBtn.mas_top);
//            make.width.equalTo(@22);
//            make.height.equalTo(@22);
//            
//        }];
    
        
        _minusBtn = [MyControl createButtonWithFrame:CGRectMake(CellWidth-15-22, CellHeight-10-22, 22, 22) ImageName:@"waimai_Minus" Target:self Action:@selector(minusBtnClick:) Title:nil];
    
        [self addSubview:_minusBtn];
        
    }
    return _minusBtn;
}


#pragma mark - Private methods
- (void)animateMinusBtn
{
    WS(ws)
    [UIView animateWithDuration:1 animations:^{
        //self.minusBtn.frame = CGRectMake(CGRectGetMinX(self.addBtn.frame)-30-22, CGRectGetMinY(self.addBtn.frame), self.addBtn.width, self.addBtn.height);
         ws.minusBtn.frame = CGRectMake(CellWidth-15-22-30-22, CGRectGetMinY(ws.addBtn.frame), ws.addBtn.width, ws.addBtn.height);
        [ws.contentView addSubview:ws.minusBtn];
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)animateWithMinusBtnOff
{
    WS(ws)
    [UIView animateWithDuration:1 animations:^{
//        self.minusBtn.frame = CGRectMake(CGRectGetMinX(self.addBtn.frame), CGRectGetMinY(self.addBtn.frame), self.addBtn.width, self.addBtn.height);
        ws.minusBtn.frame = CGRectMake(CellWidth-15-22, CellHeight-10-22, 22, 22);
        ws.productsArr = nil;
        [self setNeedsDisplay];
        
    } completion:^(BOOL finished) {
        ws.minusBtn.hidden = YES;
        [ws.minusBtn removeFromSuperview];
        ws.minusBtn = nil;
    }];
    
    
}



-(void)drawRect:(CGRect)rect
{
    //数量
    if (self.productsArr.count>0) {
        self.countStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.productsArr.count];
        CGSize countSize = [NSString getSize:self.countStr strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [self drawWithStr:self.countStr Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(CGRectGetMaxX(self.minusBtn.frame)+(25-countSize.width)/2, CGRectGetMinY(self.addBtn.frame)+(20-countSize.height)/2)];
    }
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
