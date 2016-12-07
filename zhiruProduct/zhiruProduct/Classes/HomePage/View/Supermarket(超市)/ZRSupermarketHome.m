//
//  ZRSupermarketHome.m
//  zhiruProduct
//
//  Created by nanding on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketHome.h"
#import "ZRSupermarketHomeCell.h"
#import "ZRAddShoppingCarView.h"
#import "ZRSupermarketHomeObj.h"
#import "ZRShoppingCarView.h"

#import "ZRSupermarketGoodsListModel.h"
#import "ZRSupermarketProductsListModel.h"

#define kLeftWidth            (90*ScreenWidth/375)


#define kToolHeight           (40*SCREEN_HEIGHT/667)

@interface ZRSupermarketHome ()<UITableViewDataSource, UITableViewDelegate, ZRSupermarketCellDelegate>



@property (nonatomic, strong) NSIndexPath *leftIndexPath;
@property (nonatomic, strong) NSIndexPath *rightIndexPath;




@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) ZRAddShoppingCarView *toolView;


//@property (nonatomic, strong) ZRShoppingCarView *shoppingCarView;
////灰色蒙版
//@property (nonatomic, strong) UIView *modelView;

@end

@implementation ZRSupermarketHome
#pragma mark - init methods
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.categoryTable];
        [self addSubview:self.productTable];
        
    
        //添加购物车
        _toolView = [[ZRAddShoppingCarView alloc] init];
        _toolView.viewTag = kSupermarketShoppingCar_Tag;
        _toolView.backgroundColor = [UIColor blackColor];
        _toolView.alpha = 0.9;
        
        _toolView.leftStr = @"20";
        
        [self addSubview:_toolView];
        [self bringSubviewToFront:_toolView];
        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@(kToolHeight));
            
        }];
        
        //添加观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadProduct:) name:@"SuperMarketProdectAdd" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMinusProduct:) name:@"SuperMarketProdectMinus" object:nil];
        
        //清空购物车通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearShoppingCar:) name:kClearShoppingCar_Noti object:nil];
        

    }
    return self;
}



#pragma mark - 接收通知
- (void)reloadProduct:(NSNotification *)noti
{
    //NSArray *indexArr = noti.object;
    ZRSupermarketGoodsListModel *goodsList = noti.object;
    //NSIndexPath *idxPath = [NSIndexPath indexPathForRow:[indexArr[0] integerValue] inSection:[indexArr[1] integerValue]];
   
    [_rightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZRSupermarketProductsListModel *productsList = obj;
        for (int i=0; i<productsList.goodsList.count; i++) {
            ZRSupermarketGoodsListModel *goods = productsList.goodsList[i];
            if ([goods.goods_id isEqualToString:goodsList.goods_id]) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
                ZRSupermarketHomeCell *cell = [self.productTable cellForRowAtIndexPath:idxPath];
                cell.countStr = [NSString stringWithFormat:@"%d",[cell.countStr intValue]+1];
                //cell.supermarketId = _supermarketID;
                cell.supermarketHomeModel = _supermarketHomeModel;
                [cell setNeedsDisplay];
            }
        }
        
    }];
    
    
    
    
}

- (void)reloadMinusProduct:(NSNotification *)noti
{
    //NSArray *indexArr = noti.object;
    ZRSupermarketGoodsListModel *goodsList = noti.object;
    //NSIndexPath *idxPath = [NSIndexPath indexPathForRow:[indexArr[0] integerValue] inSection:[indexArr[1] integerValue]];
    
    
    [_rightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZRSupermarketProductsListModel *productsList = obj;
        for (int i=0; i<productsList.goodsList.count; i++) {
            ZRSupermarketGoodsListModel *goods = productsList.goodsList[i];
            if ([goods.goods_id isEqualToString:goodsList.goods_id]) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
                ZRSupermarketHomeCell *cell = [self.productTable cellForRowAtIndexPath:idxPath];
                if ([cell.countStr integerValue]>1) {
                    cell.countStr = [NSString stringWithFormat:@"%d",[cell.countStr intValue]-1];
                    [cell setNeedsDisplay];
                }else{
                    //收起减号动画
                    [cell deleteAnimation];
                }

            }
        }
        
    }];
    
    
}


- (void)clearShoppingCar:(NSNotification *)noti
{
    
    [_rightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZRSupermarketProductsListModel *productsList = obj;
        for (int i=0; i<productsList.goodsList.count; i++) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
            ZRSupermarketHomeCell *cell = [self.productTable cellForRowAtIndexPath:idxPath];
            cell.countStr = nil;
            [cell setNeedsDisplay];
            //收起减号动画
            [cell deleteAnimation];
        }

        
    }];
    
    self.toolView.redLabel.text = @"0";
    self.toolView.redLabel.hidden = YES;
    self.toolView.price = 0;
    [self.toolView setNeedsDisplay];
    
    
}

#pragma mark - set 方法

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.categoryTable reloadData];
    [self.productTable reloadData];
    
    if (_leftArray.count>0) {
        if ([_leftArray containsObject:_titleString]) {
            [self tableView:self.categoryTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[_leftArray indexOfObject:_titleString] inSection:0]];
        }else{
            [self tableView:self.categoryTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }

    }
   
}




#pragma mark - 懒加载
//左侧
-(UITableView *)categoryTable
{
    if (!_categoryTable) {
        _categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, SCREEN_HEIGHT-64-kToolHeight) style:UITableViewStylePlain];
        _categoryTable.delegate = self;
        _categoryTable.dataSource = self;
        _categoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _categoryTable;
}

//右侧
-(UITableView *)productTable
{
    if (!_productTable) {
        _productTable = [[UITableView alloc] initWithFrame:CGRectMake(kLeftWidth, 0, SCREEN_WIDTH-kLeftWidth, SCREEN_HEIGHT-64-kToolHeight) style:UITableViewStylePlain];
        _productTable.delegate = self;
        _productTable.dataSource = self;
        //_productTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _productTable;
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.productTable) {
        return [self.dataSource ZRRightnumberOfSectionsInTable:tableView];
    }else
        return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTable) {
        return [self.dataSource ZRLeftnumberOfRowsInSection:section Table:tableView];
    }else{
        return [self.dataSource ZRRightnumberOfRowsInSection:section Table:tableView];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.categoryTable) {
        static NSString *cellID = @"cellID";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        // line
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35*SCREEN_HEIGHT/667-1, cell.width, 1)];
        line.backgroundColor = RGBCOLOR(240, 239, 245);
        [cell.contentView addSubview:line];
        
        UILabel *txtLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.categoryTable.width, 35*SCREEN_HEIGHT/667)];
        txtLab.text = [self.dataSource ZRLeftTableView:tableView cellForRowAtIndexPath:indexPath];
        txtLab.font = CustomFont(14);
        txtLab.textColor = RGBCOLOR(85, 85, 85);
        txtLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        txtLab.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:txtLab];
                
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = selectedView;
        
    }else{
        ZRSupermarketHomeCell *myCell = [ZRSupermarketHomeCell cellWithTable:tableView];
        for (UIView *view in myCell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        
        
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //myCell.supermarketId = _supermarketID;
        myCell.supermarketHomeModel = _supermarketHomeModel;
        
        myCell.delegate = self;
        //goodsListModel和indexPath的顺序不要反了！！！
        myCell.goodsListModel = [self.dataSource ZRRightTableView:tableView cellForRowAtIndexPath:indexPath];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:myCell.goodsListModel.img_url] placeholderImage:nil];
        
        [myCell.contentView addSubview:imgView];
        
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15*SCREEN_WIDTH/375));
            //make.centerY.equalTo(@(myCell.contentView.centerY));
            //make.centerY.equalTo(myCell.contentView.mas_centerY);
            make.top.equalTo(@(15*SCREEN_WIDTH/375));
            make.width.equalTo(@(60*SCREEN_HEIGHT/667));
            make.height.equalTo(@(60*SCREEN_HEIGHT/667));
            
        }];
        
        
        
        
        myCell.indexPath = indexPath;
        
        cell = myCell;
        
    }
    
    
    
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.categoryTable) {
        return 0;
    }else
        return 25*SCREEN_HEIGHT/667;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTable) {
        return 35*SCREEN_HEIGHT/667;
    }else{
        return 130*SCREEN_HEIGHT/667;
    }
}


#pragma mark - ZRSupermarketHomeDelegate methods


- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (tableView == self.categoryTable) {
        return view;
    }else{
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25*SCREEN_HEIGHT/667)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH-8, 25*SCREEN_HEIGHT/667)];
        label.text = [self.delegate ZRRightTitleForHeaderInSection:section RightTable:tableView];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = RGBCOLOR(85, 85, 85);
        [view addSubview:label];
    }
    return view;

}



#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTable) {

        [self.categoryTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        
        [self.productTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
#warning tableView左侧滑动控制右侧
//        CGRect rect;
//        rect = [self.productTable rectForHeaderInSection:indexPath.row];
//        [self.productTable setContentOffset:CGPointMake(0, CGRectGetMinY(rect)) animated:YES];
       
    }

    
    
}







#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.productTable) {
       
        [self scrollRightTable];
        
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    if (scrollView == self.productTable) {
        if (decelerate == 0) {
           
            [self scrollRightTable];
            
        }
    }

    
}

#pragma mark - Private methods
- (void)scrollRightTable
{
    //获取当前的section
    NSArray *indexPaths = [self.productTable indexPathsForVisibleRows];
    NSIndexPath *indexPath = indexPaths[0];
    NSIndexPath *leftIndexPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    
    [self.categoryTable selectRowAtIndexPath:leftIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)scrollToHeaderInSection:(NSIndexPath *)indexPath
{
    CGRect rect;
    rect = [self.productTable rectForHeaderInSection:indexPath.row];
    [self.productTable setContentOffset:CGPointMake(0, CGRectGetMinY(rect)) animated:YES];
}



#pragma mark - ZRSupermarketCellDelegate methods  加入购物车
/**
 *  加入购物车
 *
 *  @param cell      cell
 *  @param dataArr   每一个商品数组 @[image, name, price]
 *  @param indexPath 每个cell对应的索引
 */
-(void)addToShoppingCar:(ZRSupermarketHomeCell *)cell WithData:(ZRSupermarketGoodsListModel *)goodsListModel WithIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect parentRect = [cell convertRect:cell.addBtn.frame toView:self];
    // 添加动画
    [self JoinCartAnimationWithRect:parentRect WithCell:cell];
    self.toolView.goodsListModel = goodsListModel;

    //__block NSArray *indexArr = @[@(indexPath.row),@(indexPath.section)];
    
     //将数据添加到model中
    
    if ([ZRSupermarketHomeObj shareInstance].allProductsArray.count>0) {
        __block BOOL isAdded = NO;//该商品是否添加过，默认未添加过
        
        [[ZRSupermarketHomeObj shareInstance].allProductsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *productsArr = obj;
//            if ([productsArr[0] isEqualToArray:indexArr]) {
//                
//                [productsArr addObject:goodsListModel];
//                
//                isAdded = YES;
//                *stop = YES;
//            }
            
            ZRSupermarketGoodsListModel *goodsList = productsArr[0];
            if ([goodsList.goods_id isEqualToString:goodsListModel.goods_id]) {
                [productsArr addObject:goodsListModel];
                isAdded = YES;
                *stop = YES;
            }
            
            
        }];
        
        if (isAdded != YES) {
            //该行cell从未添加过
            
            //NSMutableArray *productsArr = [NSMutableArray arrayWithObjects:indexArr,goodsListModel, nil];
            NSMutableArray *productsArr = [NSMutableArray arrayWithObjects:goodsListModel, nil];
            [[ZRSupermarketHomeObj shareInstance].allProductsArray addObject:productsArr];
        }
     
        
        
    }else{
        //从未添加过商品
        //NSMutableArray *productsArr = [NSMutableArray arrayWithObjects:indexArr,goodsListModel, nil];
        NSMutableArray *productsArr = [NSMutableArray arrayWithObjects:goodsListModel, nil];
        [[ZRSupermarketHomeObj shareInstance].allProductsArray addObject:productsArr];
        
        
        
    }

    [self.productTable reloadData];
    
    
}



-(void)minusProduct:(ZRSupermarketHomeCell *)cell WithData:(ZRSupermarketGoodsListModel *)goodsList WithIndexPath:(NSIndexPath *)indexPath
{
    
    [self.toolView minusWithGoods:goodsList];
    
    
}



#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect WithCell:(ZRSupermarketHomeCell *)cell
{
    _endPoint_x = 35;
    _endPoint_y = self.height - 35;
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    _dotLayer = [CALayer layer];
    _dotLayer.frame = cell.addBtn.frame;
    _dotLayer.contents = (id)[ZRImage(@"supermarket_plus") CGImage];
  
    
    [self.layer addSublayer:_dotLayer];
    [self groupAnimation];
}


#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.8];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        
        [_toolView.shoppingCatBtn.layer addAnimation:shakeAnimation forKey:nil];
        
    }
}







-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
