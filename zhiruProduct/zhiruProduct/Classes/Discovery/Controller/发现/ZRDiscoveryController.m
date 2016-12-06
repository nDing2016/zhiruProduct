//
//  ZRDiscoveryController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRDiscoveryController.h"
#import "ZRSegmentView.h"
#import "ZRDiscoveryCell.h"
#import "ZRProductDetalController.h"
#import "ZRGroupBuyingDetailsController.h"

#import "ZRGroupBuyingDetailRequest.h"
#import "ZRRecommendListModel.h"

#import "ZRGroupBuyingDetailRequest.h"

#import "ZRDiscoverRequest.h"
#import "ZRRecommendModel.h"

#import "ZRIntegralMallModel.h"

#import "ZRRecommendGroupListModel.h"

#import "ZRFindNewProduct.h"

@interface ZRDiscoveryController ()<ZRSegmentViewDelegate, ZRDiscoveryCellDelegate>

@property (nonatomic, strong) ZRRecommendModel *recommendModel;

@property (nonatomic, strong) ZRIntegralMallModel *integralMall;
//积分商城数据
@property (nonatomic, strong) NSMutableArray *integralMallData;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ZRDiscoveryController
#pragma mark - lifeCycle

static NSString *ID = @"cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //qqcm112
    return [super initWithCollectionViewLayout:layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_segmentView) {
        
        if (_discoveryType == RecommendType) {
            //默认选中推荐
            [_segmentView buttonPressed:[_segmentView viewWithTag:10]];
            
        }else if (_discoveryType == IntegralMallType){
            //默认选中积分商城
            [_segmentView buttonPressed:[_segmentView viewWithTag:11]];
            
        }else{
            //默认选中新品
            [_segmentView buttonPressed:[_segmentView viewWithTag:12]];
        }
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[ZRDiscoveryCell class] forCellWithReuseIdentifier:ID];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //self.collectionView.scrollEnabled = NO;
    //setUp TitleView  For NavigationBar
    [self setUpTitleView];
    
    
    //setUp RightBarButton For NavigationBar
    //[self setUpRightBarButton];
    
    //更新积分商城首页通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshIntegralMall) name:kIntegralMallRefresh_Noti object:nil];
    

}

#pragma mark - 通知
- (void)refreshIntegralMall
{
    //积分商城
    NSIndexPath *idxPath = [NSIndexPath indexPathForItem:1 inSection:0];
    ZRDiscoveryCell *cell = (ZRDiscoveryCell *)[self.collectionView cellForItemAtIndexPath:idxPath];
    [cell.collectionView startRefreshWithCallback:^{
        [self loadLatestIntegralMallData];
        
    }];
}

#pragma mark - 懒加载
-(NSMutableArray *)integralMallData
{
    if (!_integralMallData) {
        _integralMallData = [NSMutableArray array];
    }
    return _integralMallData;
}


#pragma mark - PrivateMethods
- (void)setUpTitleView
{
    NSArray *arrar = [NSArray arrayWithObjects:@"推荐",@"积分商城",@"新品", nil];
    _segmentView = [[ZRSegmentView alloc] init];
    _segmentView.backgroundColor = [UIColor clearColor];
    _segmentView.tag = 21;
    _segmentView.textNormalColor = RGBCOLOR(85, 85, 85);
    _segmentView.delegate = self;
    _segmentView.linColor = RGBCOLOR(140, 199, 181);
    _segmentView.textFont = [UIFont systemFontOfSize:16];
    [_segmentView loadTitleArray:arrar];
    self.navigationItem.titleView = _segmentView;
    
}

//购物车
- (void)setUpRightBarButton
{
    UIButton *shoppingCartBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(JoinShoppingCart:) Title:nil];
    [shoppingCartBtn setImage:ZRImage(@"gouwuche-1") forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:shoppingCartBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
    
}


#pragma mark - click methods
- (void)JoinShoppingCart:(UIButton *)sender
{
    
}


#pragma mark - ZRSegmentViewDelegate methods
-(void)segmentView:(ZRSegmentView *)segmentView index:(NSInteger)index
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
   
}


#pragma mark - UIScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
    UIButton *button = [_segmentView viewWithTag:(10+page)];
    [_segmentView buttonPressed:button];
    
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRDiscoveryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.delegate = self;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (indexPath.item == 0) {
        //推荐
        UIImageView *tuijianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
        tuijianImgView.image = ZRImage(@"qingqidai");
        [cell.contentView addSubview:tuijianImgView];
        
        //以下暂时注掉，之后开通
        /**
        [cell.contentView addSubview:cell.tableView];
        cell.tableView.contentOffset = CGPointMake(0, 0);
        //下拉加载最新
        [cell.tableView startRefreshWithCallback:^{
            [self loadRecommendData];
        }];
         */
        
    }else if (indexPath.item == 1){
        //积分商城
        [cell.contentView addSubview:cell.collectionView];
        cell.collectionView.contentOffset = CGPointMake(0, 0);
        //下拉加载最新
        [cell.collectionView startRefreshWithCallback:^{
            [self loadLatestIntegralMallData];
            
        }];
        
        [cell.collectionView startFooterRefresh:self Action:@selector(loadMoreIntegarlMallData)];
        cell.collectionView.mj_footer.hidden = YES;
        
    }else{
        UIImageView *tuijianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
        tuijianImgView.image = ZRImage(@"qingqidai");
        [cell.contentView addSubview:tuijianImgView];
        
        //以下暂时注掉，之后开通
        /**
        //新品
        [cell.contentView addSubview:cell.tableView];
        cell.tableView.contentOffset = CGPointMake(0, 0);
        //下拉加载
        [cell.tableView startRefreshWithCallback:^{
            [self loadNewProductData];
        }];
         */
        
    }
    
    
    return cell;
}




#pragma mark - ZRDiscoveryCellDelegate methods
/**
 *  推荐----查看全部点击事件
 *
 *  @param cell
 *  @param titleStr 
 */
-(void)recommendSeeAll:(ZRDiscoveryCell *)cell WithTitle:(NSString *)titleStr
{
    if ([titleStr isEqualToString:@"热门美食"]) {
        
        
        
        
        
    }else if ([titleStr isEqualToString:@"热门丽人"]){
        
    }else if ([titleStr isEqualToString:@"热门娱乐"]){
        
    }else if ([titleStr isEqualToString:@"热门旅行"]){
        
    }else if ([titleStr isEqualToString:@"热门购物"]){
        
    }else if ([titleStr isEqualToString:@"热门生活"]){
        
    }
}

/**
 *  积分商城跳转到商品详情
 *
 *  @param cell
 *  @param index 
 */
- (void)integralMallClickToProductDetail:(ZRDiscoveryCell *)cell WithIndex:(NSInteger)index WithData:(ZRCommodityListModel *)commodityList
{
    ZRProductDetalController *productDetailCtl = [[ZRProductDetalController alloc] init];
    [self.navigationController pushViewController:productDetailCtl animated:YES];
    productDetailCtl.commodityListModel = commodityList;
}

/**
 *  跳转到团购详情页面
 */
-(void)pushToGroupBuyingDetailsControllerWithGroupList:(ZRRecommendGroupListModel *)groupListModel
{
    ZRGroupBuyingDetailsController *groupBuyingDetailsVC = [[ZRGroupBuyingDetailsController alloc] init];
    [self.navigationController pushViewController:groupBuyingDetailsVC animated:YES];
    groupBuyingDetailsVC.businessId = groupListModel.businessId;
    groupBuyingDetailsVC.groupId = groupListModel.groupId;
    
}

-(void)pushToGroupBuyingDetailsControllerWithList:(ZRFindNewProduct *)findNewProduct
{
    ZRGroupBuyingDetailsController *groupBuyingDetailsVC = [[ZRGroupBuyingDetailsController alloc] init];
    [self.navigationController pushViewController:groupBuyingDetailsVC animated:YES];
    //groupBuyingDetailsVC.businessId = findNewProduct.businessId;
    groupBuyingDetailsVC.groupId = findNewProduct.groupId;
}


#pragma mark - 网络请求数据
/**
 *  获取推荐数据
 */
- (void)loadRecommendData
{
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    
    WS(ws)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ZRDiscoverRequest requestForRecommentWithLongitude:address.Longitude WithLatitude:address.Latitude WithCallback:^(id details, NSError *error) {
            
            NSMutableArray *dataArr = [NSMutableArray array];
            NSMutableArray *navClickArr = [NSMutableArray array];
            
            NSIndexPath *idx = [NSIndexPath indexPathForItem:0 inSection:0];
            ZRDiscoveryCell *cell = (ZRDiscoveryCell *)[ws.collectionView cellForItemAtIndexPath:idx];
            
            [cell.tableView.mj_header endRefreshing];
            
            [details enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
    
                _recommendModel = [ZRRecommendModel mj_objectWithKeyValues:obj];
                if (_recommendModel.groupList.count>0) {
                    
                    [dataArr addObject:_recommendModel];
                    
                    [navClickArr addObject:@(idx)];
                }
                
                cell.navClick = navClickArr;
                [cell.navImgArr addObject:_recommendModel.imgUrl];
                [cell.navTitleArr addObject:_recommendModel.navName];
    
            }];
            
            //获取到数据，回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.cellIndex = index0;
                cell.dataArray = dataArr;
                [cell showUpButton:YES];
            });
    
    
        }];
    
    });

    
    
    
}

/**
 *  获取积分商城最新数据
 */
- (void)loadLatestIntegralMallData
{
    //每次下拉获取最新数据时，应清空数组
    _integralMallData = [NSMutableArray array];
    _page = 1;
    
    
    WS(ws)
    
    [ZRDiscoverRequest requestForIntegralMallWithRows:@"6" WithPage:@"1" WithCallback:^(id details, NSError *error) {
        
        NSIndexPath *idx = [NSIndexPath indexPathForItem:1 inSection:0];
        ZRDiscoveryCell *cell = (ZRDiscoveryCell *)[ws.collectionView cellForItemAtIndexPath:idx];
        [cell.collectionView.mj_header endRefreshing];
        cell.collectionView.mj_footer.state = MJRefreshStateIdle;
        
        cell.cellIndex = index1;
        //cell.collectionArray = @[@"1",@"2"];
        [cell showUpButton:NO];
        
        
        _integralMall = [ZRIntegralMallModel mj_objectWithKeyValues:details];
        
        [_integralMall.commodityLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ws.integralMallData addObject:obj];
            
            if (idx == _integralMall.commodityLists.count-1) {
                [ws.integralMallData insertObject:_integralMall.img atIndex:0];
                cell.collectionFirstImg = _integralMall.img;
                cell.collectionArray = ws.integralMallData;
            }
            
        }];

        
        
    }];

    
    
}

/**
 *  获取积分商城更多数据
 */
- (void)loadMoreIntegarlMallData
{
    //页数加加，如果没有更多数据了page--
    _page++;
    
    WS(ws)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZRDiscoverRequest requestForIntegralMallWithRows:@"6" WithPage:[NSString stringWithFormat:@"%ld",(long)ws.page] WithCallback:^(id details, NSError *error) {
            
            NSIndexPath *idx = [NSIndexPath indexPathForItem:1 inSection:0];
            ZRDiscoveryCell *cell = (ZRDiscoveryCell *)[ws.collectionView cellForItemAtIndexPath:idx];
            
            [cell.collectionView.mj_footer endRefreshing];
            
            _integralMall = [ZRIntegralMallModel mj_objectWithKeyValues:details];
            if (_integralMall.commodityLists.count<1) {
                //无更多数据了
                cell.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
                _page--;
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    cell.cellIndex = index1;
                    //cell.collectionArray = @[@"1",@"2"];
                    [cell showUpButton:NO];
                    
//#warning 假数据
//                    //NSMutableArray *arr = [NSMutableArray array];
                    
                    [_integralMall.commodityLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [ws.integralMallData addObject:obj];
                        
                        if (idx == _integralMall.commodityLists.count-1) {
                            cell.collectionFirstImg = _integralMall.img;
                            cell.collectionArray = ws.integralMallData;
                        }
                        
                    }];
                    
                    
                    
                    
                    
                    
                });

                
            }
            
            
            
            
        }];
        
        
    });

    
    
    
}


/**
 *  获取新品数据
 */
- (void)loadNewProductData
{
     ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ZRDiscoverRequest requestForNewProdectWithLongitude:address.Longitude WithLatitude:address.Latitude WithCallback:^(id details, NSError *error) {
            
            NSIndexPath *idx = [NSIndexPath indexPathForItem:2 inSection:0];
            ZRDiscoveryCell *cell = (ZRDiscoveryCell *)[ws.collectionView cellForItemAtIndexPath:idx];
            [cell.tableView.mj_header endRefreshing];
            //获取到数据，回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.backgroundColor = [UIColor grayColor];
                cell.cellIndex = index2;                
                [cell showUpButton:NO];
                cell.dataArray = details;
                
            });
            
            
        }];
        
    });

}


#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
