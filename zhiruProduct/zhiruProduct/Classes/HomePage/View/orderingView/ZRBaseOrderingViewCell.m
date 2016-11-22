//
//  ZRBaseOrderingViewCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseOrderingViewCell.h"
#import "ZROrdeingCarteCell.h" //菜单
#import "ZRCommentCell.h" //外卖点评
#import "ZRBusinessDetailsCollectionCell.h" //商家详情

#import "ZRAddShoppingCarView.h"
@interface ZRBaseOrderingViewCell ()<UICollectionViewDelegate , UICollectionViewDataSource , ZROrdeingCarteCellDelegate >

@property (nonatomic  , strong) UICollectionView * myCollectionView;

@end

@implementation ZRBaseOrderingViewCell



-(void)setBusinessModel:(ZROrderingDetailModel  *)businessModel{
    _businessModel = businessModel;
    
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {

    }
    return self;
}



-(UICollectionView *)myCollectionView{
    
    if (_myCollectionView == nil) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height) collectionViewLayout:flowLayout];
        
        //每个 item大小
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 203 + 90);
        //间距
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        [_myCollectionView setPagingEnabled:YES];
        [_myCollectionView setShowsHorizontalScrollIndicator:NO];
        [_myCollectionView registerClass:[ZROrdeingCarteCell class] forCellWithReuseIdentifier:@"Cell"];//菜单
        [_myCollectionView registerClass:[ZRCommentCell class] forCellWithReuseIdentifier:@"commentCell"];
        [_myCollectionView registerClass:[ZRBusinessDetailsCollectionCell class] forCellWithReuseIdentifier:@"businessCell"];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        
       
        _myCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
        
  
        
        [self addSubview:_myCollectionView];
    }
    return _myCollectionView;
}





#pragma mark -- CollectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //如果 是 午餐 这里返回2
    if (_isLunch == YES) {
        return 2;
    }else{
        return 3;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row ==0) {
        static NSString * ordeingCell = @"Cell";
        
        ZROrdeingCarteCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ordeingCell forIndexPath:indexPath];
    
        
        cell.delegate = self;
        cell.footListModel = _businessModel;
        [cell sizeToFit];
        
        return cell;
        
    }
    //午餐
    else if(indexPath.row == 1 && _isLunch == NO){
         static NSString * commentCell = @"commentCell";
        
        ZRCommentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:commentCell forIndexPath:indexPath];
        
        return cell;
        
    }
    else if (indexPath.row == 1 && _isLunch == YES){
        static NSString * businessCell = @"businessCell";
        
        ZRBusinessDetailsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:businessCell forIndexPath:indexPath];
        cell.model = _businessModel.businessMsg;
        cell.isLunch = YES;
        return cell;
    }
    
    else{
        
        static NSString * businessCell = @"businessCell";
        
        ZRBusinessDetailsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:businessCell forIndexPath:indexPath];
        
        cell.model = _businessModel.businessMsg;
        return cell;
    }
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint pInView = [self convertPoint:self.myCollectionView.center toView:self.myCollectionView];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.myCollectionView indexPathForItemAtPoint:pInView];
    // 赋值给记录当前坐标的变量
    if (self.cellDisplaying) {

        self.cellDisplaying(indexPathNow);
    }
   
}

#pragma mark -- 代理
- (void)ordeingCarteDidScrollWithOffsetY:(CGFloat)offsetY {
    if ([self.delegate respondsToSelector:@selector(baseOrderingViewCellDidScrollWithOffsetY:)]) {
        [self.delegate baseOrderingViewCellDidScrollWithOffsetY:offsetY];
    }
}

-(void)setIndex:(NSInteger)index{
    _index = index;
     [_myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    //切换的时候，隐藏购物车
    UIWindow  *myWindow = [UIApplication sharedApplication].keyWindow;
    UIView *view = nil;
    for (view in myWindow.subviews) {
        if ([view isMemberOfClass:[ZRAddShoppingCarView class]]) {

            if (index == 0) {
                view.hidden = NO;
            }else{
                view.hidden = YES;
            }
        }
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
