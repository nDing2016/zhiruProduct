//
//  ZRSupermarketHomeController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketHomeController.h"
#import "ZRSupermarketHome.h"
#import "ZRSupermarketRequest.h"
#import "ZRSupermarketProductsListModel.h"

#import "ZRSupermarketGoodsListModel.h"

#import "ZRConfirmOrderController.h"

#import "ZRSupermarketHomeObj.h"

#import "ZRUserInterfaceModel.h"
#import "ZRUserFindAddressModel.h"

#import "ZRSupermarketAllListModel.h"

#import "ZRSupermarketGoodsTool.h"

@interface ZRSupermarketHomeController ()<ZRSupermarketHomeDataSource, ZRSupermarketHomeDelegate>


@property (nonatomic, strong) NSMutableArray *leftArr;

@property (nonatomic, strong) NSMutableArray *rightArr;

@property (nonatomic, strong) ZRSupermarketProductsListModel *productsListModel;

@property (nonatomic, strong) ZRSupermarketGoodsListModel *goodsListModel;


@property (nonatomic, strong) ZRSupermarketAllListModel *allListModel;

@property (nonatomic, copy) NSString * latitude;
@property (nonatomic , copy) NSString * longitude;
@property (nonatomic, copy) NSString * weather;

@property (nonatomic, strong) ZRSupermarketHome *supermarketHome;

@end

@implementation ZRSupermarketHomeController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"超市到家";
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectFinished:) name:kShoppingCarSelectFinished_Noti object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addToShoppingCarNoti:) name:kSupermarketAddToShoppingCar_Noti object:nil];
    
    
    [SVProgressHUD show];
    
    
    [self loadLocalData];
    
    
    [self loadAllGoodsListData];
    
    
    [ZRSupermarketRequest requestWeatherandSuccess:^(id success) {
        _weather = success;
    } andFailure:^(id error) {
        
    }];
    

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}





-(void)viewWillDisappear:(BOOL)animated
{
    
    
    
    [super viewWillDisappear:animated];
//    self.rightArr = [NSMutableArray array];
//    self.leftArr = [NSMutableArray array];
//    for (UIView *view in self.view.subviews) {
//        [view removeFromSuperview];
//    }
    
    
}



- (void)loadAllGoodsListData
{
    WS(ws)
    if (_supermarketModel.kaId) {
        
        [ZRSupermarketRequest requestSupermarketProductsListWithSuperId:_supermarketModel.kaId Callback:^(id details, NSError *error) {
            
            ws.allListModel = [ZRSupermarketAllListModel mj_objectWithKeyValues:details];
            //归档
            if ([ZRSupermarketGoodsTool saveGoodsList:ws.allListModel] == YES) {
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD dismiss];
            }
            
            
            //距离
            //            ws.longitude = details[@"longitude"];
            //            ws.latitude = details[@"latitude"];
            
            ws.longitude = ws.allListModel.longitude;
            ws.latitude = ws.allListModel.latitude;
            
            
            ws.rightArr = [NSMutableArray array];
            ws.leftArr = [NSMutableArray array];
            
            //NSMutableArray *arr = [NSObject mj_objectArrayWithKeyValuesArray:details[@"list"]];
            __block NSInteger index;
            [ws.allListModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //_productsListModel = obj;
                _productsListModel = [ZRSupermarketProductsListModel mj_objectWithKeyValues:obj];
                if (_productsListModel.goodsList.count>0) {
                    [ws.rightArr addObject:_productsListModel];
                    [ws.leftArr addObject:_productsListModel.navName];
                }
                
                index = idx;
                
            }];
            
            if (index == ws.allListModel.list.count-1) {
                //[SVProgressHUD dismiss];
                ws.supermarketHome.leftArray = ws.leftArr;
                ws.supermarketHome.rightArray = ws.rightArr;
                ws.supermarketHome.titleString = ws.titleStr;
                ws.supermarketHome.supermarketHomeModel = ws.supermarketModel;
                
            }
            
            
            
            
            
            
        }];
    }

}




- (void)loadLocalData
{
    //先判断本地是否有缓存，如果有则直接取出
    if ([ZRSupermarketGoodsTool allGoodsListModel]){
        //有缓存
        [SVProgressHUD dismiss];
        self.allListModel = [ZRSupermarketGoodsTool allGoodsListModel];
        self.longitude = self.allListModel.longitude;
        self.latitude = self.allListModel.latitude;
        
        
        __block NSInteger index;
        self.rightArr = [NSMutableArray array];
        self.leftArr = [NSMutableArray array];
        [self.allListModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            _productsListModel = [ZRSupermarketProductsListModel mj_objectWithKeyValues:obj];
            if (_productsListModel.goodsList.count>0) {
                [self.rightArr addObject:_productsListModel];
                [self.leftArr addObject:_productsListModel.navName];
            }
            
            index = idx;
            
        }];
        
        if (index == self.allListModel.list.count-1) {
            //[SVProgressHUD dismiss];
            
            self.supermarketHome.leftArray = self.leftArr;
            self.supermarketHome.rightArray = self.rightArr;
            self.supermarketHome.titleString = self.titleStr;
            self.supermarketHome.supermarketHomeModel = self.supermarketModel;
        }
        
        
        
    }

}



-(ZRSupermarketHome *)supermarketHome
{
    if (!_supermarketHome) {
        _supermarketHome = [[ZRSupermarketHome alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_supermarketHome];
        _supermarketHome.dataSource = self;
        _supermarketHome.delegate = self;
        
        
        
    }
    return _supermarketHome;
}



#pragma mark - 通知
/**
 *  加入购物车按钮
 */
- (void)addToShoppingCarNoti:(NSNotification *)noti
{
    [SVProgressHUD show];
    if ([ZRSupermarketHomeObj shareInstance].allProductsArray.count>0) {
        WS(ws)
        NSMutableArray *listArr = [NSMutableArray array];
        for (NSArray *productsArr in [ZRSupermarketHomeObj shareInstance].allProductsArray) {
            NSMutableDictionary *listDic = [NSMutableDictionary dictionary];
            ZRSupermarketGoodsListModel *model = productsArr[0];
            [listDic setObject:model.goods_id forKey:@"goodsId"];
            [listDic setObject:ws.supermarketModel.kaId forKey:@"kaId"];
            [listDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)productsArr.count] forKey:@"num"];
            [listArr addObject:listDic];
            
        }
        //未支付的时候，需要将商品保存到购物车中
        [ZRSupermarketRequest requestAddKaShoppingCartWithList:listArr Callback:^(NSString *codeStr, NSString *message, NSError *error) {
            
            if ([codeStr isEqualToString:@"C004"]) {
                [SVProgressHUD dismiss];
                //用户未登录
                [ZRAlertControl notLoginAlert:ws goLogin:^{
                    
                    //弹出登录页面
                    ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
                    ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                    
                    [ws presentViewController:nav animated:YES completion:nil];
                    
                }];
                
            }else if([codeStr isEqualToString:@"S000"]){
                
                //NSLog(@"加入购物车成功");
                [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
                [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
                
                
            }
            
            
            
            
        }];
 
    }else{
        //NSLog(@"您还没选呢");
    }
    
}



//选好了跳转事件
- (void)selectFinished:(NSNotification *)noti
{
    
    WS(ws)
    [SVProgressHUD show];
  
    [ZRUserInterfaceModel userFineDefaultAddressCallBack:^(id result) {
        ZRUserFindAddressModel * model = result;
        NSString * longitude;
        NSString * latitude;
        if (model == nil) {
            ZRUserAddress * address = [ZRUserAddress sharedInstance];
            
            longitude = address.Longitude;
            latitude = address.Latitude;
        }else{
            longitude  = model.longitude;
            latitude = model.latitude;
        }
   
         [ZRSupermarketRequest requestGetDustabceWithLongitudeOne:_longitude andLatitudeOne:_latitude andLongitudeTwo:longitude andLatitudeTwo:latitude andSuccess:^(id success) {
             
             [SVProgressHUD dismiss];
             
             NSString * distanceStr = success;
             if ([ZRUserTool user]) { // 已经登录
                 ZRConfirmOrderController *confirmOrderVC = [[ZRConfirmOrderController alloc] init];
                 [ws.navigationController pushViewController:confirmOrderVC animated:YES];
                 confirmOrderVC.longitude = ws.longitude;
                 confirmOrderVC.latitude = ws.latitude;
                 confirmOrderVC.distanceStr = distanceStr;
                 confirmOrderVC.addressModel = model;
                 confirmOrderVC.weather = [_weather floatValue];
                 confirmOrderVC.orderType = Supermarket;
                 confirmOrderVC.supermarketHomeModel = ws.supermarketModel;
                 confirmOrderVC.isDeliver = YES;
                 NSArray * array = [ZRSupermarketHomeObj shareInstance].allProductsArray;
                 confirmOrderVC.productArr = array;
                 
             }else{ // 未登录
                 //用户未登录
                 [ZRAlertControl notLoginAlert:ws goLogin:^{
                     
                     //弹出登录页面
                     ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
                     ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                     
                     [ws presentViewController:nav animated:YES completion:nil];
                     
                     
                 }];
                 
                 
             }

         } andFailure:^(id error) {
             [SVProgressHUD dismiss];
             [SVProgressHUD showErrorWithStatus:@"请求失败"];
             [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
             
         }];
        //首先判断用户是否登录
     
        
    } Filure:^(id error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        
        
    }];
   
    
    
    
}


#pragma mark - 懒加载
//-(NSArray *)leftArr
//{
//    if (!_leftArr) {
//        _leftArr = @[@"新品上市",@"最新折扣",@"休闲零食",@"火锅精选",@"粮油副食",@"牛奶果汁",@"饮料冲饮",@"速冻美味",@"方便面线"];
//    }
//    return _leftArr;
//}



#pragma mark - ZRSupermarketHomeDataSource methods
-(NSInteger)ZRLeftnumberOfRowsInSection:(NSInteger)section Table:(UITableView *)table
{
    
    return self.leftArr.count;
}



-(NSString *)ZRLeftTableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.leftArr[indexPath.row];
}

-(NSInteger)ZRRightnumberOfSectionsInTable:(UITableView *)table
{
    return self.rightArr.count;
}

-(NSInteger)ZRRightnumberOfRowsInSection:(NSInteger)section Table:(UITableView *)table
{
    _productsListModel = self.rightArr[section];
    return _productsListModel.goodsList.count;
}

/**
 *  返回每一个商品数组  @[image,name,price]
 */
-(ZRSupermarketGoodsListModel *)ZRRightTableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _productsListModel = self.rightArr[indexPath.section];
    _goodsListModel = _productsListModel.goodsList[indexPath.row];
    return _goodsListModel;
}



#pragma mark - ZRSupermarketHomeDelegate
-(NSString *)ZRRightTitleForHeaderInSection:(NSInteger)section RightTable:(UITableView *)table
{
    return self.leftArr[section];
}


#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    self.rightArr = nil;
    self.leftArr = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //取消当前网络请求
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
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
