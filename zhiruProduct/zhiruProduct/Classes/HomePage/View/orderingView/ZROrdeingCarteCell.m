//
//  ZROrdeingCarteCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrdeingCarteCell.h"
#import "ZRCarteTableViewCell.h"
#import "ZRAddShoppingCarView.h"
#import "ZRSupermarketHomeObj.h"
#import "ZROrderingFootListModel.h"
#import "ZRConfirmOrderController.h"

#define kToolHeight           (40*SCREEN_HEIGHT/667)


@interface ZROrdeingCarteCell ()<UITableViewDelegate , UITableViewDataSource, ZRCarteTableViewCellDelegate>

@property (nonatomic , strong) UIView * leftBarView;

@property (nonatomic ,strong) UIScrollView *leftScr;

//当前假数据---- 后期换成后台接收数据,响应方法位置也要换
@property (nonatomic ,strong) NSMutableArray * CarteTitleArr;

@property (nonatomic , strong) UITableView * rightTableView;
@property (nonatomic , weak) UIButton * selectBtn;

@property (nonatomic , assign) CGFloat LastOffset;

@property (nonatomic , assign) CGFloat rightOffset;

@property (nonatomic , strong) NSMutableArray * leftButtonMarr;



@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;
//@property (nonatomic, strong)ZRAddShoppingCarView *toolView;
@property (nonatomic,assign) BOOL  CarteCell;
@end


@implementation ZROrdeingCarteCell

-(void)setFootListModel:(ZROrderingDetailModel *)footListModel{
    _footListModel = footListModel;
    
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    
    [self createLeftTitle];
}

-(NSMutableArray *)leftButtonMarr{
    if (_leftButtonMarr == nil) {
        _leftButtonMarr = [NSMutableArray array];

    }
    return _leftButtonMarr;
}

- (UITableView *)rightTableView{
    if (_rightTableView == nil ) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth -90 ,self.contentView.height  ) style:UITableViewStylePlain];
        
        [self addSubview:_rightTableView];
        
        _rightTableView.backgroundColor = [UIColor clearColor];
        
        _rightTableView.rowHeight = UITableViewAutomaticDimension;
        _rightTableView.estimatedRowHeight = 120.0;
        
        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _rightTableView.tableFooterView = footView;
    }
    return _rightTableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //左边栏
        _leftBarView = [UIView new];
        _leftBarView.backgroundColor = R_G_B_16(0xfafafa);
        [self addSubview:_leftBarView];
        
        _leftScr = [MyControl createUIScrollViewWithFrame:CGRectMake(0, 0, 90, self.contentView.height ) contentSize:CGSizeMake(90, _CarteTitleArr.count * 40) pagingEnabled:NO showsHorizontalScrollIndicator:NO showsVerticalScrollIndicator:NO delegate:self];
        [self addSubview:_leftScr];
        
//        //底部加入购物车工具条
//        _toolView = [[ZRAddShoppingCarView alloc] init];
//        _toolView.viewTag = kWaimaiShoppingCar_Tag;
//        _toolView.backgroundColor = [UIColor blackColor];
//        _toolView.alpha = 0.9;
//        
//        
//        
//        
//        
//        UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
//        [myWindow addSubview:_toolView];
//        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@0);
//            make.left.equalTo(@0);
//            make.right.equalTo(@0);
//            make.height.equalTo(@(kToolHeight));
//        }];
        
        
        
        //接受通知，将购物车传过来的值进行更新
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addReloadTable:) name:@"WaimaiProdectAdd" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusReloadTable:) name:@"WaimaiProdectMinus" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearWaimaiShoppingCar:) name:kWaimaiClearshoppingCar_Noti object:nil];
        
        //午餐支付完成跳转回午餐订餐页面
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRightTable) name:@"WuCanZhifuWanChengClearTableNoti" object:nil];
        
    }
    return self;
}


- (NSMutableArray *)CarteTitleArr{
    if (_CarteTitleArr == nil) {
        _CarteTitleArr = [NSMutableArray array];
        
        if (_footListModel== nil) {
            return [NSMutableArray array];
        }
        NSArray * titleArr = _footListModel.footList;
        for (int i = 0; i < titleArr.count; i ++) {
            ZROrderingFootListModel * footModel = titleArr[i];
            [_CarteTitleArr addObject:footModel.categoryName];
        }
        
    }
    return _CarteTitleArr;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    WS(ws)
    [self.leftBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.left.equalTo(ws.mas_left);
        make.bottom.equalTo(ws.mas_bottom);
        make.width.mas_equalTo(90);
    }];
}


#pragma mark - 通知
- (void)addReloadTable:(NSNotification *)noti
{
//    NSIndexPath *idxPath = noti.object;
//    ZRCarteTableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:idxPath];
//    cell.countStr = [NSString stringWithFormat:@"%ld",[cell.countStr integerValue]+1];
//    [cell setNeedsDisplay];
    
    ZROrderingMenuModel *menu = noti.object;
    [_footListModel.footList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZROrderingFootListModel *foods = obj;
        for (int i=0; i<foods.menu.count; i++) {
            ZROrderingMenuModel *menuModel = foods.menu[i];
            if ([menu.menu_id isEqualToString:menuModel.menu_id]) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
                ZRCarteTableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:idxPath];
                cell.countStr = [NSString stringWithFormat:@"%ld",[cell.countStr integerValue]+1];
                [cell setNeedsDisplay];
            }
        }
        
    }];
    
    
}


- (void)minusReloadTable:(NSNotification *)noti
{
//    NSIndexPath *idxPath = noti.object;
//    ZRCarteTableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:idxPath];
//    if ([cell.countStr integerValue]>1) {
//        cell.countStr = [NSString stringWithFormat:@"%ld",[cell.countStr integerValue]-1];
//        [cell setNeedsDisplay];
//    }else{
//        //收起减号动画
//        [cell animateWithMinusBtnOff];
//    }
    
    
    ZROrderingMenuModel *menu = noti.object;
    [_footListModel.footList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZROrderingFootListModel *foods = obj;
        for (int i=0; i<foods.menu.count; i++) {
            ZROrderingMenuModel *menuModel = foods.menu[i];
            if ([menu.menu_id isEqualToString:menuModel.menu_id]) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
                ZRCarteTableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:idxPath];
                if ([cell.countStr integerValue]>1) {
                    cell.countStr = [NSString stringWithFormat:@"%ld",[cell.countStr integerValue]-1];
                    [cell setNeedsDisplay];
                }else{
                    //收起减号动画
                    [cell animateWithMinusBtnOff];
                }

            }
        }
        
    }];

    
}

/**
 *  清空外卖购物车
 */
- (void)clearWaimaiShoppingCar:(NSNotification *)noti
{
    [_footListModel.footList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZROrderingFootListModel *foods = obj;
        for (int i=0; i<foods.menu.count; i++) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:idx];
            ZRCarteTableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:idxPath];
            cell.countStr = nil;
            [cell setNeedsDisplay];
            [cell animateWithMinusBtnOff];
            
        }
    }];
    
    
    
    
//    [self.toolView.redLabel removeFromSuperview];
//    self.toolView.redLabel = nil;
//    self.toolView.price = 0;
//    [self.toolView setNeedsDisplay];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderingClear_Noti object:nil];
    
}



- (void)reloadRightTable
{
    [self.rightTableView reloadData];
}


#pragma mark - 创建左边栏标题
- (void)createLeftTitle{
    for (int i = 0; i<self.CarteTitleArr.count; i++) {
        //NSLog(@"%@",self.CarteTitleArr);
        UIButton *button = [MyControl createButtonWithFrame:CGRectMake(0, 40*i, 90*SCALE, 40) ImageName:nil Target:self Action:@selector(leftBarBtnClick:) Title:self.CarteTitleArr[i]];
        button.titleLabel.font = CustomFont(Font_Content);
        [button setTitleColor:R_G_B_16(0x555555) forState:UIControlStateNormal];
        [button setBackgroundColor:R_G_B_16(0xf0f0f0) forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [self.leftScr addSubview:button];
        
        [self.leftButtonMarr addObject:button];
        if (i == 0) {
            button.selected = YES;
            _selectBtn = button;
        }
    }
    
}


#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.CarteTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZROrderingFootListModel * model = _footListModel.footList[section];
    
    return model.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZROrderingFootListModel * model = _footListModel.footList[indexPath.section];
    
    static NSString * Cell = @"CarteCell";
    
    if (!_CarteCell) {
        UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZRCarteTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cell];
        _CarteCell = YES;
    }
    
//    ZRCarteTableViewCell * carteCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    ZRCarteTableViewCell * carteCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (carteCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRCarteTableViewCell class]) owner:self options:nil];
        carteCell = [nibs lastObject];
    }
    
    carteCell.menuModel = model.menu[indexPath.row];
    carteCell.selectionStyle = UITableViewCellSelectionStyleNone;
    carteCell.delegate = self;
    carteCell.productsArr = nil;
    carteCell.idxPath = indexPath;
    
    return carteCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    
    if (sectionTitle==nil) {
        
        return nil;
        
    }
    
    // Create label with section title
    
    UILabel *label=[[UILabel alloc] init] ;
    
    label.backgroundColor=[UIColor clearColor];
    
    label.textColor=[UIColor blackColor];
    
    label.font=[UIFont systemFontOfSize:14];
    
    label.text=sectionTitle;
    
    label.textColor = R_G_B_16(0x555555);
    
    // Create header view and add label as a subview
    
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] ;
    
    [sectionView setBackgroundColor:R_G_B_16(0xf0f0f0)];
    
    [sectionView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(12);
        make.centerY.equalTo(sectionView.mas_centerY);
    }];
    
    return sectionView;
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return self.CarteTitleArr[section];
}

#pragma mark -- 监听滑动距离
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    //89
    CGFloat lastOffset;
    if (scrollView == self.rightTableView) {
        lastOffset = _LastOffset ;
    }else{
        lastOffset = _rightOffset;
    }

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tableViewDidScroll" object:nil userInfo:@{@"offsetY":@(offsetY - lastOffset)}];
    

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.rightTableView) {
        _LastOffset = scrollView.contentOffset.y;
    }else{
        _rightOffset = scrollView.contentOffset.y;
    }

    NSArray * cellArr = [self.rightTableView indexPathsForVisibleRows];
    
    if (cellArr.count == 0) {
        return;
    }
    NSIndexPath * indexP = cellArr[0];
    
    if (self.leftButtonMarr[indexP.section] != _selectBtn) {
        
        _selectBtn.selected = NO;
        
        UIButton * btn =  self.leftButtonMarr[indexP.section];
        btn.selected = YES;
        
        _selectBtn = btn;
    }
}

#pragma mark -- 左边栏点击事件
- (void)leftBarBtnClick :(UIButton *)btn{
    
    _selectBtn.selected = NO;
    
    btn.selected = YES;
    
    _selectBtn = btn;
    
    NSInteger count = btn.tag - 100;
    //NSLog(@"%ld",(long)count);
    ZROrderingFootListModel * model = _footListModel.footList[count];

    if (model.menu.count == 0) {
        count ++;
    }
    
    [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:count] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
}


#pragma mark - ZRCarteTableViewCellDelegate methods 添加到购物车按钮点击事件代理方法
-(void)addFoods:(ZRCarteTableViewCell *)cell ForIndexPath:(NSIndexPath *)idxPath
{
    //添加动画
    
    CGRect parentRect = [cell convertRect:cell.addBtn.frame toView:self];
    // 添加动画
    [self JoinCartAnimationWithRect:parentRect WithCell:cell];
    
    
    //通知更新toolView
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderingAdd_Noti object:cell.menuModel];
    
    //self.toolView.orderingMenuModel = cell.menuModel;

    
}


-(void)minusFoods:(ZRCarteTableViewCell *)cell ForIndexPath:(NSIndexPath *)idxPath
{
    //[self.toolView minusWithGoods:cell.menuModel];
    //通知更新toolView
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderingMinus_Noti object:cell.menuModel];
}


#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect WithCell:(ZRCarteTableViewCell *)cell
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
    _dotLayer.contents = (id)[ZRImage(@"jiahao") CGImage];
    
    
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
        
        //[_toolView.shoppingCatBtn.layer addAnimation:shakeAnimation forKey:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderingAnimation_Noti object:shakeAnimation];
        
    }
}


#pragma mark - dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WaimaiProdectAdd" object:nil];
}

@end
