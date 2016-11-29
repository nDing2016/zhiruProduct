//
//  ZROrderingDetailsController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingDetailsController.h"
#import "orderingDetailsHeadView.h"
#import "orderingSectionView.h"
#import "ZRBaseOrderingViewCell.h"
#import "ZRAddShoppingCarView.h"
#import "ZRHomePageRequst.h"
#import "ZROrderingDetailModel.h"
#import "ZRShareView.h"
#import "ZROrderingBusinessMsgModel.h"
#import "ZRConfirmOrderController.h"
#import "ZRSupermarketHomeObj.h"
#import "ZRLunchSectionView.h"
#import "ZRAddShoppingCarView.h"
#import "ZRSupermarketRequest.h"

#define kToolHeight          (40*SCREEN_HEIGHT/667)


@interface ZROrderingDetailsController ()< UITableViewDelegate , UITableViewDataSource , ZRBaseOrderingViewCellDelegate >
@property (nonatomic  , strong) UIView * headView;

@property (nonatomic  , strong) UITableView * myTableView;

@property (nonatomic  , strong) ZRBaseOrderingViewCell * cell;

@property (nonatomic  , strong) orderingSectionView *  sectionView;

@property (nonatomic  , assign) CGFloat offsetY;

@property (nonatomic , strong) ZROrderingDetailModel * detailModel;
@property (nonatomic , strong) ZRLunchSectionView * lunchView;
@property (nonatomic , strong) ZRAddShoppingCarView * toolView;

@property (nonatomic , copy) NSString * longitude;
@property (nonatomic , copy) NSString * latitude;
@property (nonatomic , copy) NSString * weather;
@end

@implementation ZROrderingDetailsController

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , ScreenHeight  ) style:UITableViewStylePlain];
        
        [self.view addSubview:_myTableView];
        
        _myTableView.backgroundColor = [UIColor clearColor];
        
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.estimatedRowHeight = 120.0;
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        //禁止此tableview滚动
        _myTableView.scrollEnabled =NO;
        
        orderingDetailsHeadView * headView = [[[NSBundle mainBundle] loadNibNamed:@"orderingDetailsHeadView" owner:self options:nil] lastObject];
        
       
        if (_isLunch == YES) {
            headView.isLunch = YES;
        }
        
        //ZROrderingBusinessMsgModel * model;
        headView.frame = CGRectMake(0, 0, ScreenWidth, headView.height);
        headView.model = _detailModel.businessMsg;
        _headView = headView;
        
        _myTableView.tableHeaderView = headView;
    }
    return  _myTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        
    }
    

    
    //添加导航条右按钮
//    [self createNavRightBtn];
    [self createNotification];
   
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:ZRNotificationOrderClick object:nil];
    
    
    //添加购物车通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrderingNoti:) name:kOrderingAdd_Noti object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusOrderingNoti:) name:kOrderingMinus_Noti object:nil];
    
    //添加购物车动画
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addShoppingCarAnimation:) name:kOrderingAnimation_Noti object:nil];
    
    //清空购物车
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearShoppingCar:) name:kOrderingClear_Noti object:nil];
    
    
    
}


- (void)clearShoppingCar:(NSNotification *)noti
{
//    [self.toolView.redLabel removeFromSuperview];
//    self.toolView.redLabel = nil;
    self.toolView.redLabel.text = @"0";
    self.toolView.redLabel.hidden = YES;
    self.toolView.price = 0;
    [self.toolView setNeedsDisplay];

}

- (void)addShoppingCarAnimation:(NSNotification *)noti
{
    CABasicAnimation *shakeAnimation = noti.object;
    [_toolView.shoppingCatBtn.layer addAnimation:shakeAnimation forKey:nil];
}


- (void)addOrderingNoti:(NSNotification *)noti
{
    ZROrderingMenuModel *model = noti.object;
    self.toolView.orderingMenuModel = model;
}

- (void)minusOrderingNoti:(NSNotification *)noti
{
    ZROrderingMenuModel *model = noti.object;
    [self.toolView minusWithGoods:(NSObject *)model];
}


-(void)notice:(id)sender{
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        
        //弹出登录页面
        ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
        ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
        
        [self presentViewController:nav animated:YES completion:nil];

    } else {
        WS(ws)
        [SVProgressHUD show];
        [ZRUserInterfaceModel userFineDefaultAddressCallBack:^(id result) {
            ZRUserFindAddressModel * model = result;
            NSString * longitude;
            NSString * latitude;
            if (model == nil) {
                ZRUserAddress * address = [[ZRUserAddress alloc] init];
                
                longitude = address.Longitude;
                latitude = address.Latitude;
            }else{
                longitude  = model.longitude;
                latitude = model.latitude;
            }
            
            [ZRSupermarketRequest requestGetDustabceWithLongitudeOne:_longitude andLatitudeOne:_latitude andLongitudeTwo:longitude andLatitudeTwo:latitude andSuccess:^(id success) {
                
                [SVProgressHUD dismiss];
                
                
                NSString * distanceStr = success;
                
                NSArray * arr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
                
                
                ZRConfirmOrderController *confirmOrderVC = [[ZRConfirmOrderController alloc] init];
                [ws.navigationController pushViewController:confirmOrderVC animated:YES];
                confirmOrderVC.longitude = ws.longitude;
                confirmOrderVC.latitude = ws.latitude;
                confirmOrderVC.distanceStr = distanceStr;
                confirmOrderVC.productArr = arr;
                
                if (_isLunch == YES) {
                    confirmOrderVC.orderType = lunchOrdering;
                }
                confirmOrderVC.addressModel = model;
                confirmOrderVC.weather = [_weather floatValue];
                confirmOrderVC.orderType = Ordering;
                //                confirmOrderVC.supermarketHomeModel = ws.supermarketModel;
                confirmOrderVC.isDeliver = YES;
                NSArray * array = [ZRSupermarketHomeObj shareInstance].allProductsArray;
                confirmOrderVC.productArr = array;
                ZROrderingBusinessMsgModel * model = self.detailModel.businessMsg;
                if ([model.paymentMethod isEqualToString:@"1"]) {
                    confirmOrderVC.isOnlinePay = YES;
                }
                
                confirmOrderVC.businessMsg = model;
                if ([model.specialDelivery isEqualToString:@"1"]) {
                    confirmOrderVC.isDeliver = YES;
                }else{
                    confirmOrderVC.isDeliver = NO;
                }
                
                confirmOrderVC.title = @"确认订单";
                
                
                
            } andFailure:^(id error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [ws performSelector:@selector(dismiss) withObject:nil afterDelay:1];
                
            }];
            //首先判断用户是否登录
            
            
        } Filure:^(id error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [ws performSelector:@selector(dismiss) withObject:nil afterDelay:1];
            
            
        }];
    }



    

    
    
    
    
    //..........................................
    
//    NSArray * arr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
    
//    ZRConfirmOrderController * confirmOrder = [[ZRConfirmOrderController alloc] init];
    
 
    
//    confirmOrder.productArr = arr;
    
//    ZROrderingBusinessMsgModel * model = self.detailModel.businessMsg;
//    if ([model.paymentMethod isEqualToString:@"1"]) {
//        confirmOrder.isOnlinePay = YES;
//    }
//    
//    confirmOrder.businessMsg = model;
//    if ([model.specialDelivery isEqualToString:@"1"]) {
//        confirmOrder.isDeliver = YES;
//    }else{
//        confirmOrder.isDeliver = NO;
//    }
//    
//    confirmOrder.title = @"确认订单";
//    [self.navigationController pushViewController:confirmOrder animated:YES];
}

- (void)setIsLunch:(BOOL)isLunch {
    _isLunch = isLunch;

    //午餐 网络请求写在下面   并将tableview.dele设置下
    [self getLunchData];
}

- (void)setBusinessId:(NSString *)businessId{
    _businessId = businessId;
    
    [self getOrderingDetailsData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self homeInitialization];
    [self weatherNumber];
    //底部加入购物车工具条
    _toolView = [[ZRAddShoppingCarView alloc] init];
    _toolView.viewTag = kWaimaiShoppingCar_Tag;
    _toolView.backgroundColor = [UIColor blackColor];
    _toolView.alpha = 0.9;
    
    
    
    
    
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:_toolView];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(kToolHeight));
    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    
    //视图将要消失，移除购物车工具栏
    UIWindow  *myWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in myWindow.subviews) {
        if ([view isMemberOfClass:[ZRAddShoppingCarView class]]) {
            [view removeFromSuperview];
        }
    }
    
}

#pragma mark -- 初始化
- (void)homeInitialization{
    
   
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[NAVCOLOR colorWithAlphaComponent:0]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
   
}

#pragma mark - 导航条右按钮
- (void)createNavRightBtn{
    
//    UIButton * rightBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(rightBtnClick:) Title:nil];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn.tag = 0;
    [rightBtn setImage:[UIImage imageNamed:@"fenxiang_hui"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn sizeToFit];
    
//    UIButton * rightIslikeBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(rightBtnClick:) Title:nil];
    UIButton * rightIslikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightIslikeBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightIslikeBtn setImage:[UIImage imageNamed:@"islike"] forState:UIControlStateNormal];
    [rightIslikeBtn setImage:[UIImage imageNamed:@"islike_hong"] forState:UIControlStateSelected];
    [rightIslikeBtn sizeToFit];
    rightIslikeBtn.tag = 1;
    UIBarButtonItem *rightIsLikeItem = [[UIBarButtonItem alloc]initWithCustomView:rightIslikeBtn];

    
//    [self.navigationItem setRightBarButtonItems:@[rightIsLikeItem,rightItem];
    self.navigationItem.rightBarButtonItems = @[rightIsLikeItem,rightItem];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"baseCell";
    
    ZRBaseOrderingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
    if (cell == nil) {
        cell = [[ZRBaseOrderingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        _cell = cell;
        cell.delegate = self;
        WS(ws)
        //里面的视图 横向滚动停止调用
        if (_isLunch == YES) {
            cell.cellDisplaying = ^(NSIndexPath * indexPath){
                ws.lunchView.index = indexPath.row;
            };
        }else{
            cell.cellDisplaying = ^(NSIndexPath * indexPath){
                ws.sectionView.index = indexPath.row;
            };
        }
        
        
    }
    if (_isLunch == YES) {
        cell.isLunch = YES;
    }
    cell.businessModel = _detailModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight - 203 + 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    

    if (_isLunch == YES) {
        ZRLunchSectionView * lunchView =  [[[NSBundle mainBundle] loadNibNamed:@"ZRLunchSectionView" owner:self options:nil] lastObject];
        _lunchView = lunchView;
        
        UIView * view = [UIView new];
        
        view.frame = CGRectMake(0, 0, ScreenWidth, 50);
        
        [view addSubview:_lunchView];
        
        [_lunchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.top.equalTo(view.mas_top);
            make.height.equalTo(@50);
        }];
        
        WS(ws)
        
        lunchView.btnClick = ^(NSInteger index){
            ws.cell.index = index;
            
        };
        
        return view;
    }else{
        orderingSectionView * sectionView = [[[NSBundle mainBundle] loadNibNamed:@"orderingSectionView" owner:self options:nil] lastObject];
        _sectionView = sectionView;
        
        UIView * view = [UIView new];
        
        view.frame = CGRectMake(0, 0, ScreenWidth, 50);
        
        [view addSubview:_sectionView];
        
        [_sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.top.equalTo(view.mas_top);
            make.height.equalTo(@50);
        }];
        
        WS(ws)
        
        sectionView.btnClick = ^(NSInteger index){
            ws.cell.index = index;
            
        };
        
        return view;
    }
    
//    _sectionView = sectionView;
    
   
}

#pragma mark -- 滑动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    _offsetY = offsetY;
    if (offsetY > 0) {
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        [self.navigationController.navigationBar lt_setBackgroundColor:[NAVCOLOR colorWithAlphaComponent:alpha]];
        [self.navigationItem setTitleView:[MyControl createNavigationTitle:_detailModel.businessMsg.businessName]];
    } else {
        [self.navigationItem setTitleView:[UIView new]];
        [self homeInitialization];
    }
    
}



- (void)createNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewDidScroll:) name:@"tableViewDidScroll" object:nil];
    
}

- (void)tableViewDidScroll :(NSNotification *)noti {
    CGFloat offsetY = [noti.userInfo[@"offsetY"] floatValue];
    
    CGFloat currentOffset = self.myTableView.contentOffset.y;
    currentOffset += offsetY;
    
    self.myTableView.contentOffset = CGPointMake(0, currentOffset);
    if (_offsetY > 89) {
        self.myTableView.contentOffset = CGPointMake(0, 89);
    }
    if (_offsetY<0) {
        self.myTableView.contentOffset = CGPointMake(0, 0);
    }
}



#pragma mark - 右导航条按钮点击
- (void)rightBtnClick :(UIButton * ) btn{
    
    switch (btn.tag) {
        case 0:
            //NSLog(@"点击分享");
            //分享
        {
            ZROrderingBusinessMsgModel * model = self.detailModel.businessMsg;
            
            NSMutableArray *temImgArr = [NSMutableArray array];
            
            if (model.imgUrl.length>0) {
                [temImgArr addObject:model.imgUrl];
            }else{
                [temImgArr addObject:@""];
            }
            
            
            NSArray *imgesArr = [NSArray arrayWithArray:temImgArr];
            NSString *shareUrlStr = [NSString stringWithFormat:@"http://www.sharesdk.cn"];
            ZRShareView *shareView = [[ZRShareView alloc]init];
            //                WS(ws);
            [shareView createUIWithTitle:model.businessName andText:model.notice andImages:imgesArr andUrlStr:shareUrlStr  andSuccess:^{
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            } andFail:^{
                
                
            } andCancle:^{
                
                
            }];
        
        }
            
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 网络请求

- (void)getOrderingDetailsData{
    
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestOrderingDetailsWithLongitude:address.Longitude andLatitude:address.Latitude andBusinessId:_businessId andSuccess:^(id success) {
        
        ZROrderingDetailModel * detailsModel = success;
        
        
        _detailModel = detailsModel;
        
        ws.myTableView.delegate = self;
        ws.myTableView.dataSource = self;
        
        
    } andFailure:^(id error) {
        
    }];
}

- (void)getLunchData{
    WS(ws)
    [ZRHomePageRequst requestGetLunchInfoAndSuccess:^(id success) {
        ZROrderingDetailModel * detailsModel = success;
        
        
        _detailModel = detailsModel;
        ws.myTableView.delegate = self;
        ws.myTableView.dataSource = self;
    } andFailure:^(id error) {
        
    }];
}

- (void)weatherNumber
{
    dispatch_queue_t queue = dispatch_queue_create("com.zr.weather", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [ZRSupermarketRequest requestWeatherandSuccess:^(id success) {
            _weather = success;
        } andFailure:^(id error) {
            
        }];
    });
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
