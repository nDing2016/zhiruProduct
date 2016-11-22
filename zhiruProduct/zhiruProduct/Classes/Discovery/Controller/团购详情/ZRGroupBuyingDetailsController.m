//
//  ZRGroupBuyingDetailsController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingDetailsController.h"
#import "ZRGroupBuyingDetailsCell.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "AppDelegate.h"
#import "ZRDiscoveryController.h"
#import "ZRGroupBuyingDetailsToolView.h"

#import "ZRSuitableMerchantController.h"
#import "ZRImageTextDetailsController.h"
#import "ZRAllReviewsController.h"
#import "ZRBuyImmediateController.h"
#import "ZRProductDetailsController.h"

#import "ZRGroupBuyingDetailRequest.h"
#import "ZRGroupBuyDetailModel.h"
#import "ZRGoodsModel.h"
#import "ZRGoodsListModel.h"

#import "ZRGroupBuyDetailsFrame.h"

#import "ZRMapViewController.h"

@interface ZRGroupBuyingDetailsController ()<UITableViewDataSource, UITableViewDelegate, ZRGroupBuyingDetailsToolViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZRGroupBuyingDetailsToolView *toolView;


//团购详情数据
@property (nonatomic, strong) ZRGroupBuyDetailModel *detailModel;
@property (nonatomic, strong) ZRGroupBuyDetailsFrame *groupDetailsFrame;

@end

@implementation ZRGroupBuyingDetailsController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加购物车，分享，收藏
    [self setUpRightBarButtonItems];
    
    //添加详情的headImage
    [self.view addSubview:self.tableView];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_isClickCell == NO) {
        //返回到推荐界面
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        ZRTabBarViewController *tabCtl = (ZRTabBarViewController *)dele.window.rootViewController;
        ZRNavigationController *nav = tabCtl.childViewControllers[1];
        ZRDiscoveryController *discoveryCtl = nav.childViewControllers[0];
        discoveryCtl.discoveryType = RecommendType;
    }
    
    

}

- (void)setGroupId:(NSString *)groupId{
    _groupId = groupId;
    WS(ws)
    [self.tableView startRefreshWithCallback:^{
        [ws loadData];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //下拉加载
    //[self.tableView startRefresh:self Action:@selector(loadData)];
  
    
}

#pragma mark - Private methods
/**
 *  添加顺序：分享，收藏，购物车
 */
- (void)setUpRightBarButtonItems
{
    
   
//    CGSize size = [NSString getSize:_navTitle strFont:[UIFont systemFontOfSize:21] maxSize:self.view.size];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    titleLabel.text = _navTitle;
//    titleLabel.textColor = RGBCOLOR(85, 85, 85);
//    titleLabel.textAlignment = NSTextAlignmentRight;
//    titleLabel.font = [UIFont systemFontOfSize:21];
//    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:ZROriginImage(@"groupBuyingDetails_Share") style:UIBarButtonItemStyleDone target:self action:@selector(shareClick:)];
    [shareItem setImageInsets:UIEdgeInsetsMake(0, 40, 0, -40)];
    
    //判断是否已经收藏
//    if () {
//        
//    }
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithImage:ZROriginImage(@"groupBuyingDetails_Collection") style:UIBarButtonItemStyleDone target:self action:@selector(collectionClick:)];
    [collectionItem setImageInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    
    UIBarButtonItem *shoppingCarItem = [[UIBarButtonItem alloc] initWithImage:ZROriginImage(@"gouwuche-1") style:UIBarButtonItemStyleDone target:self action:@selector(shoppingCarClick:)];
    //[shoppingCarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    self.navigationItem.rightBarButtonItems = @[shoppingCarItem, collectionItem, shareItem];
    
    
}


#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
        _tableView.backgroundView = nil;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


-(ZRGroupBuyingDetailsToolView *)toolView
{
    if (!_toolView) {
        CGFloat height = 40*ScreenHeight/667;
        _toolView = [[ZRGroupBuyingDetailsToolView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
        _toolView.nowPrice = self.detailModel.nowPrice;
        _toolView.originalPrice = self.detailModel.oldPrice;
        _toolView.delegate = self;
    }
    return _toolView;
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.detailModel.otherGroupNum integerValue]>0) {
        return 6;
    }else
        return 5;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.detailModel.otherGroupNum integerValue]>0) {
        if (section == 0) {
            return 2;
        }else if (section == 1){
            return 3;
        }else if (section == 2){
            
            return 2;
        }else if (section == 3){
            return 2;
        }else if (section == 4){
            return [self.detailModel.otherGroupNum integerValue]+1;
        }else
            if (self.detailModel.commentList.count>0) {
                return 3+self.detailModel.commentList.count;
            }else
                return 1;
    }else{
        if (section == 0) {
            return 2;
        }else if (section == 1){
            return 3;
        }else if (section == 2){
            
            return 2;
        }else if (section == 3){
            return 2;
        }else
            if (self.detailModel.commentList.count>0) {
                return 3+self.detailModel.commentList.count;
            }else
                return 1;
    }
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRGroupBuyingDetailsCell *cell = [ZRGroupBuyingDetailsCell cellWithTable:self.tableView forIndexPath:indexPath WithData:self.detailModel];
    
//    cell.saledCount = self.detailModel.sold_num;
//    cell.headImage = [UIImage getImageFromURL:self.detailModel.groupImg];
//    cell.detailsModel = self.detailModel;
    cell.groupDetailsFrame = _groupDetailsFrame;
    cell.idxPath = indexPath;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}




#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            h = 182*SCREEN_HEIGHT/667;
        }else{
            h = 40*SCREEN_HEIGHT/667;
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            h = 40*SCREEN_HEIGHT/667;
        }else if (indexPath.row == 1){
            h = 75*SCREEN_HEIGHT/667;
        }else{
            h = 40*SCREEN_HEIGHT/667;
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            h = 40*SCREEN_HEIGHT/667;
        }else{
            int num = 0;
            for (int i=0; i<self.detailModel.goods.count; i++) {
                ZRGoodsModel *goods = self.detailModel.goods[i];
                num = num+ 1+(int)goods.goodsList.count;
            }
            num = num+3;
            h = num*(25*SCREEN_HEIGHT/667)+(30*SCREEN_HEIGHT/667);
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            h = 40*SCREEN_HEIGHT/667;
        }else{
            h = _groupDetailsFrame.cellHeight;
        }
    }else{
    
        if ([self.detailModel.otherGroupNum integerValue]>0)
        {
            if (indexPath.section == 4){
                if (indexPath.row == 0) {
                    h = 40*SCREEN_HEIGHT/667;
                }else{
                    h = 60*SCREEN_HEIGHT/667;
                }
            }else if (indexPath.section == 5){
                if (self.detailModel.commentList.count>0) {
                    if (indexPath.row == 0) {
                        h = 40*SCREEN_HEIGHT/667;
                    }else if (indexPath.row == 1){
                        h = 90*SCREEN_HEIGHT/667;
                    }else if (indexPath.row == 2 || indexPath.row == 3){
                        h = 230*SCREEN_HEIGHT/667;
                    }
                    else{
                        h = 40*SCREEN_HEIGHT/667;
                    }
                }else{
                    h = 40*SCREEN_HEIGHT/667;
                }
                
            }
        }else{
            if (indexPath.section == 4) {
                if (self.detailModel.commentList.count>0) {
                    if (indexPath.row == 0) {
                        h = 40*SCREEN_HEIGHT/667;
                    }else if (indexPath.row == 1){
                        h = 90*SCREEN_HEIGHT/667;
                    }else if (indexPath.row == 2 || indexPath.row == 3){
                        h = 230*SCREEN_HEIGHT/667;
                    }
                    else{
                        h = 40*SCREEN_HEIGHT/667;
                    }
                }else{
                    h = 40*SCREEN_HEIGHT/667;
                }
            }
        }
    }
    return h;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //适用商户
            if (self.detailModel.businessNum != nil) {
                ZRSuitableMerchantController *suitableMerchantVC = [[ZRSuitableMerchantController alloc] init];
                [self.navigationController pushViewController:suitableMerchantVC animated:YES];
            }
            
        }else if (indexPath.row == 1){
            //详情
            ZRProductDetailsController *productDetailsVC = [[ZRProductDetailsController alloc] init];
            [self.navigationController pushViewController:productDetailsVC animated:YES];
            
        }else if (indexPath.row == 2){
            //地图
            ZRMapViewController *mapVC = [[ZRMapViewController alloc] init];
            [self.navigationController pushViewController:mapVC animated:YES];
#warning 传经纬度
            
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            //团购详情
            ZRImageTextDetailsController *imageTextVC = [[ZRImageTextDetailsController alloc] init];
            [self.navigationController pushViewController:imageTextVC animated:YES];
        }
    }else if (indexPath.section == 5){
        if (indexPath.row == 4) {
            //查看全部网友点评  团购
            ZRAllReviewsController *allReviewVC = [[ZRAllReviewsController alloc] init];
            [self.navigationController pushViewController:allReviewVC animated:YES];
            allReviewVC.reviewsType = ZRGroupBuyingReviews;
            allReviewVC.commentListArray = _detailModel.commentList;
//            if (_detailModel.praise == nil) {//好评数
//                _detailModel.praise = @"0";
//            }else if (_detailModel.commentCount == nil){//全部评论
//                _detailModel.commentCount = @"0";
//            }else if (_detailModel.bad == nil){//差评数
//                _detailModel.bad = @"0";
//            }else if (_detailModel.imgComment == nil){//带图评论
//                _detailModel.imgComment = @"0";
//            }
            
            
            
            allReviewVC.goodReviewsCount = _detailModel.praise;
            allReviewVC.allReviewsCount = _detailModel.commentCount;
            allReviewVC.badReviewsCount = _detailModel.bad;
            allReviewVC.imgReviewsCount = _detailModel.imgComment;
        }
    }
}


#pragma mark - click methods
/**
 *  分享点击事件
 */
- (void)shareClick:(id)sender
{
    
}


/**
 *  收藏点击事件 
 */
- (void)collectionClick:(id)sender
{
    // go
}


/**
 *  添加购物车点击事件
 */
- (void)shoppingCarClick:(id)sender
{
    
}


#pragma mark - ZRGroupBuyingDetailsToolViewDelegate methods
/**
 *   立即购买
 */
-(void)buyImmediate
{
    ZRBuyImmediateController *buyImmediateVC = [[ZRBuyImmediateController alloc] init];
    [self.navigationController pushViewController:buyImmediateVC animated:YES];
    
    buyImmediateVC.groupBuyDetailModel = _detailModel;
    
}


#pragma mark - 网络请求获取数据
- (void)loadData
{
    //NSLog(@"%@",self.groupId);
    WS(ws)
     ZRUserAddress * address = [ZRUserAddress sharedInstance];
    //多线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程请求数据
        //网络请求
        [ZRGroupBuyingDetailRequest getGroupBuyingDetailsWithLongitude:address.Longitude Latitude:address.Latitude GroupId:ws.groupId BusinessId:ws.businessId Callback:^(id details, NSError *error){
            if (details) {
                //团购详情里 需要添加是否 收藏
                _detailModel = [ZRGroupBuyDetailModel mj_objectWithKeyValues:details];
                _groupDetailsFrame = [[ZRGroupBuyDetailsFrame alloc] init];
                _groupDetailsFrame.groupDetailsModel = _detailModel;
                //添加底部工具条
                [ws.view addSubview:ws.toolView];
                
            }else{
                //NSLog(@"=======%@",error);
            } 
            //停止刷新
            [ws.tableView.mj_header endRefreshing];
            //回到主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.navigationItem.title = ws.detailModel.groupName;
                [ws.tableView reloadData];
            });
            
        }];
        
    });
    
    

}


#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
