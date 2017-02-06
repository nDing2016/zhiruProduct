//
//  ZRHomeController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeController.h"
#import "ZRHomeHeadView.h"

#import "ZRSearchView.h"
#import "ZRHomeCellOne.h"
#import "ZRHomeCellTwo.h"
#import "ZRLookForTasteController.h"
#import "ZROrderingController.h"
#import "ZRSupermarketController.h"
#import "ZRGroupBuyingController.h"
#import "ZREntertainmentController.h"

#import "ZRBeautyController.h"

#import "ZRProductDetailsController.h"
#import "ZRTravelViewController.h"

#import "ZRHomePageRequst.h"

#import "ZRHomeDataModel.h"

#import "ZRExtensionModel.h"

#import "ZRNavModel.h"

#import "ZRHomeNavModel.h"
#import "ZRRegionModel.h"
#import "ZRLabelModel.h"
#import "ZROrderingModel.h"

#import "ZROrderingDetailsController.h"
#import "ZRSetUpController.h"
#import "ZRSettingRequest.h"
#import "ZRVersionNumberModel.h"
#import "ZRErrorController.h"
#import "ZRMyLocation.h"
#define NAVBAR_CHANGE_POINT 50

@interface ZRHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView * homeTableView;
/**顶部的视图*/
@property(nonatomic , strong) UIView *topView;
/**搜索栏的视图*/
@property(nonatomic , weak) ZRSearchView * searchView;
/**左按钮*/
@property(nonatomic , weak) UIButton * leftBtn;
/**右按钮*/
@property(nonatomic , weak) UIButton * rightBtn;

@property(nonatomic , assign) BOOL  isTop;

@property(nonatomic , strong)ZRHomeDataModel * model;

@property (nonatomic , assign) BOOL cellTwo;

@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@end

@implementation ZRHomeController




#pragma mark -- 创建tableView

-(UITableView *)homeTableView{
    if (_homeTableView == nil) {
        UITableView * homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , ScreenHeight - 44)];
        [self.view addSubview:homeTableView];
        _homeTableView = homeTableView;
        homeTableView.backgroundColor = [UIColor clearColor];
//        homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        homeTableView.rowHeight = UITableViewAutomaticDimension;
        homeTableView.estimatedRowHeight = 120.0;
        
        homeTableView.tableFooterView = [[UIView alloc] init];
        

        
        
    }
    return _homeTableView ;
}



- (void)setUpButtons
{
   

    ZRHomeHeadView * headView = [[ZRHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 409)];
    headView.model = _model;
    
    WS(ws)
    headView.clickBtn = ^(NSInteger index){
        NSArray * mainNav = _model.mainNav;
         ZRUserAddress * userAdd = [ZRUserAddress sharedInstance];

        [CustomHudView show];
        switch (index) {
            case 0: //寻味
            {
                
//                if (1) {
//                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
//                    [self.navigationController  pushViewController:setUpView animated:YES];
//                    [CustomHudView dismiss];
//                    return;
//                }
                
                ZRNavModel * modelUrl = mainNav[0];

                [ZRHomePageRequst requestGetMainNavWithUrl:[NSString stringWithFormat:@"%@findtaste/index",HOST] andLongitude:userAdd.Longitude andLatitude:userAdd.Latitude andSuccess:^(NSMutableArray *marr) {
                    ZRHomeNavModel * model = marr[0];
                    
                    NSDictionary * screeningDict = [NSDictionary dictionaryGetScreeningWithModel:model isPaixu : YES];
                    
                    ZRLookForTasteController * lookVC = [[ZRLookForTasteController alloc] initWithTitleArr:@[@"火锅",@"烧烤",@"川湘菜",@"粤菜",@"江浙菜",@"米线面食",@"小吃",@"甜品"] andScreeningDict: screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:@[@"x---huoguo",@"shaokao",@"chuancai",@"yuecai",@"jiangzhecai",@"mianshi",@"xiaochi",@"x_tiandian-1"] ];
                    lookVC.model = model;
//                    lookVC.modelArr = model.businessMsg;
                    lookVC.title = modelUrl.nav_name;
                    lookVC.latitude = ws.latitude;
                    lookVC.longitude = ws.longitude;
                    [ws.navigationController pushViewController:lookVC animated:YES];
                    
                    [CustomHudView dismiss];

                } andFailure:^(id error) {
                    [CustomHudView dismiss];
                }];
            }
                break;
            case 1: //团购
            {

                if (/* DISABLES CODE */ (1)) {
                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
                    [self.navigationController  pushViewController:setUpView animated:YES];
                    [CustomHudView dismiss];
                    return;
                }
                
                 [ZRHomePageRequst requestGetMainNavWithUrl:[NSString stringWithFormat:@"%@group/index",HOST]  andLongitude:userAdd.Longitude andLatitude:userAdd.Latitude andSuccess:^(NSMutableArray *marr) {
                     
                     ZRHomeNavModel * model = marr[0];
                     //地理
                     NSMutableArray * regionMarr = [NSMutableArray array];
                     for (ZRRegionModel * region in model.region) {
                         if (region.region_name != nil) {
                             [regionMarr addObject:region.region_name];
                         }
                         
                     }
                     //品类
                     NSMutableArray * labelMarr = [NSMutableArray array];
                     for (ZRLabelModel * label in model.label) {
                         if (label.nav_name != nil) {
                             [labelMarr addObject:label.nav_name];
                         }
                     }
                     
                     //按钮名称
                     NSMutableArray * titleArr = [NSMutableArray array];
                     
                     //后期 后台有图片 再修改button设置图片方法
                     NSMutableArray * titleImgArr = [NSMutableArray array];
                     
                     for (ZRNavModel * nav in model.nav) {
                         if (nav.nav_name != nil) {
                             [titleArr addObject:nav.nav_name];
                         }
                         if (nav.img_url != nil) {
                             [titleImgArr addObject:nav.img_url];
                         }
                         
                     }
                    
                     ZRGroupBuyingController * groupVC = [[ZRGroupBuyingController alloc] initWithTitleArr:titleArr andScreeningDict:@{@"地理":regionMarr,@"品类":labelMarr,@"排序":@[@"销量最高",@"价格最低",@"价格最高"]} andQueryTitleArr:@[@"地理",@"品类",@"排序"]andTitleImgArr:@[@"tuanxunwei",@"tuanliren",@"tuanyule",@"tuanlvyou",@"tuanshenghuo",@"tuang",@"tuanxuegao",@"tuanhuoguo"]];
                     
                     groupVC.title = @"团购";
                     groupVC.model = model;
                     [ws.navigationController pushViewController:groupVC animated:YES];
                     
                      [CustomHudView dismiss];
                 } andFailure:^(id error) {
                      [CustomHudView dismiss];
                 }];
                
                           }
                break;
            case 2: //订餐
            {
                
                if (/* DISABLES CODE */ (1)) {
                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
                    [self.navigationController  pushViewController:setUpView animated:YES];
                    [CustomHudView dismiss];
                    return;
                }
                [ZRHomePageRequst requestOrderingListWithLongitude:userAdd.Longitude  andLatitude:userAdd.Latitude andLabel:nil andSuccess:^(id success) {
                    
                    
                    ZROrderingModel * model = success;
                    
                    //品类
                    NSMutableArray * labelMarr = [NSMutableArray array];
                    for (ZRLabelModel * label in model.label) {
                        if (label.nav_name != nil) {
                            [labelMarr addObject:label.nav_name];
                        }
                    }
                    
                    
                    ZROrderingController * orderingVC = [[ZROrderingController alloc] initWithTitleArr:@[@"简餐",@"川菜",@"粤菜",@"私厨",@"东北菜",@"甜品",@"待定",@"待定"] andScreeningDict:@{@"地理":@[@"3km以内",@"3km-5km",@"5km-8km"],@"品类": labelMarr ,@"排序":@[@"智能排序",@"离我最近",@"评价最好",@"口感最佳",@"环境最佳",@"服务最佳",@"设施最佳",@"效果最佳",@"销量最高",@"价格最低",@"价格最高",@"新品"],@"筛选":@[@"支持自取",@"在线支付",@"XX专送",@"优惠活动"]} andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:@[@"d_chuangxiangcai",@"d_yuecai",@"d_jiancan",@"d_chaocai",@"d_jiangzhecai",@"d_mianshi",@"d_xiaochitianpin",@"d_sichu"]];
                    
                    orderingVC.dataArr = model;
                    
                    [ws.navigationController pushViewController:orderingVC animated:YES];
                    [CustomHudView dismiss];
                } andFailure:^(id error) {
                    [CustomHudView dismiss];
                }];
                
        
            }
                break;
            case 3: //娱乐
            {
//                if (1) {
//                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
//                    [self.navigationController  pushViewController:setUpView animated:YES];
//                    [CustomHudView dismiss];
//                    return;
//                }
//                ZRNavModel * modelUrl = mainNav[3];
                
                
                ZRUserAddress * address = [ZRUserAddress sharedInstance];
                
                   [ZRHomePageRequst requestGetMainNavWithUrl:[NSString stringWithFormat:@"%@recreation/index",HOST ]  andLongitude:address.Longitude andLatitude:address.Latitude andSuccess:^(NSMutableArray *marr) {
                       
                       ZRHomeNavModel * model = marr[0];
                       //地理
                       NSMutableArray * regionMarr = [NSMutableArray array];
                       for (ZRRegionModel * region in model.region) {
                           if (region.region_name != nil) {
                               [regionMarr addObject:region.region_name];
                           }
                           
                       }
                       //品类
                       NSMutableArray * labelMarr = [NSMutableArray array];
                       for (ZRLabelModel * label in model.label) {
                           if (label.nav_name != nil) {
                               [labelMarr addObject:label.nav_name];
                           }
                       }
                       
                       NSDictionary * screeningDict = @{@"地理":regionMarr, @"品类":labelMarr , @"排序":@[@"离我最近",@"评价最好",@"设施最佳",@"环境最佳",@"服务最佳"],@"筛选":@[@"优惠",@"营业中",@"新店"]};
                       
                       ZREntertainmentController * entertainmentVC = [[ZREntertainmentController alloc] initWithTitleArr:@[@"KTV",@"密室",@"台球",@"桌球"] andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:@[@"y_ktv",@"y_mishitaotuo",@"y_zuoqiu",@"y_zhuoyou"]];
                       
                       entertainmentVC.longitude = _longitude;
                       entertainmentVC.latitude = _latitude;
                       entertainmentVC.title = @"娱乐";
                       entertainmentVC.model = model;
                       [ws.navigationController pushViewController:entertainmentVC animated:YES];
                       
                       [CustomHudView dismiss];
                       
                   } andFailure:^(id error) {
                       
                       [CustomHudView dismiss];
                   }];
                
            }
                break;
                
            case 4: //丽人
            {
//                if (1) {
//                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
//                    [self.navigationController  pushViewController:setUpView animated:YES];
//                    [CustomHudView dismiss];
//                    return;
//                }
//                ZRNavModel * modelUrl = mainNav[4];

                 [ZRHomePageRequst requestGetMainNavWithUrl:[NSString stringWithFormat:@"%@modelling/index",HOST ] andLongitude:userAdd.Longitude andLatitude:userAdd.Latitude andSuccess:^(NSMutableArray *marr) {
                     
                     ZRHomeNavModel * model = marr[0];
                     //地理
                     NSMutableArray * regionMarr = [NSMutableArray array];
                     for (ZRRegionModel * region in model.region) {
                         if (region.region_name != nil) {
                             [regionMarr addObject:region.region_name];
                         }
                         
                     }
                     //品类
                     NSMutableArray * labelMarr = [NSMutableArray array];
                     for (ZRLabelModel * label in model.label) {
                         if (label.nav_name != nil) {
                             [labelMarr addObject:label.nav_name];
                         }
                     }
                     
                    NSDictionary * screeningDict = @{@"地理":regionMarr, @"品类":labelMarr , @"排序":@[@"离我最近",@"评价最好",@"效果最佳",@"环境最佳",@"服务最佳"],@"筛选":@[@"优惠",@"营业中",@"新店"]};
                     
                     ZRBeautyController * beautyVC = [[ZRBeautyController alloc] initWithTitleArr:@[@"美发",@"美甲",@"美容",@"纤体"] andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:@[@"l_MEIFA",@"L_MEIJIA",@"LI_MEIRONG",@"LIREN_XIANTI"]];
                     beautyVC.title = @"丽人";
                     beautyVC.model = model;
                     beautyVC.latitude = _latitude;
                     beautyVC.longitude = _longitude;
                     [ws.navigationController pushViewController:beautyVC animated:YES];
                     
                     [CustomHudView dismiss];
                 } andFailure:^(id error) {
                     [CustomHudView dismiss];
                 }];
                
            }
                break;
            case 5://午餐
            {
                ZROrderingDetailsController * detailsVC = [[ZROrderingDetailsController alloc] init];
                detailsVC.isLunch = YES;
                 [CustomHudView dismiss];
                [self.navigationController  pushViewController:detailsVC animated:YES];

            }
                break;
            case 6: //旅行
            {
           
                [CustomHudView dismiss];
                ZRSupermarketController * supermarketVC = [[ZRSupermarketController alloc] init];
                
                [ws.navigationController pushViewController:supermarketVC animated:YES];
                
            }
                break;
                
            case 7: //超市
            {
                if (/* DISABLES CODE */ (1)) {
//                    ZRSetUpController * setUpView = [[ZRSetUpController alloc] init];
//                    [self.navigationController  pushViewController:setUpView animated:YES];
                    [CustomHudView dismiss];
                    return;
                }
                ZRTravelViewController * travelVC = [[ZRTravelViewController alloc] init];
                [CustomHudView dismiss];
                
                [ws.navigationController pushViewController:travelVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    };
  
    self.homeTableView.tableHeaderView = headView;
}


#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    //上线注释
    //ZRUserAddress * address = [ZRUserAddress sharedInstance];
    //address.Longitude = @"103";
    //address.Latitude = @"26";

    //_longitude = address.Longitude;
    //_latitude = address.Latitude;

    
    //等model
//    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    _isTop = YES;
   
    

   
    //创建右按钮
    [self createNavRightBtn];
    
    [self homeInitialization];
    //创建搜索框
    [self createSearchTitle];
    
    //创建左按钮
    [self createNavLeftBtn];

    
    //定位
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeMethod:) name:kCoodinate_Noti object:nil];
    
    [[ZRMyLocation shareInstance] getMylocation];
    

    
    
    dispatch_queue_t queue = dispatch_queue_create("com.zr.update", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        [ZRSettingRequest getVersionNumberCallBack:^(id success) {
            ZRVersionNumberModel * model = success;
            
            model.name = [model.name stringByReplacingOccurrencesOfString:@"." withString:@""];
            if (model.name.integerValue > currentVersion.integerValue) {
                [self updateAPP];
            }
//            if (![currentVersion isEqualToString:model.name]) {
//                [self updateAPP];
//            }
        } Failure:^(id error) {
            
        }];
    });
}

- (void)noticeMethod : (NSNotification *)noti {
    
    //
    //    _longitude =noti.userInfo[@"longitude"];
    //    _latitude = noti.userInfo[@"latitude"];
    //
    //    [self.homeTableView reloadData];
    if ([noti.userInfo[@"longitude"] isEqualToString:@"0"]) {
        //取不到坐标
        ZRErrorController * errorVC = [[ZRErrorController alloc] init];
        
        [self presentViewController:errorVC animated:YES completion:^{
            
        }];
    }else{
        
        ZRUserAddress * address = [ZRUserAddress sharedInstance];
        address.Longitude = noti.userInfo[@"longitude"];
        address.Latitude = noti.userInfo[@"latitude"];
        _longitude = address.Longitude;
        _latitude = address.Latitude;
//        [self loadNewData];
                
        [self.homeTableView startRefreshWithCallback:^{
            [self loadNewData];
        }];
        
    }
    
}

- (void)updateAPP{
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新的版本,请您更新最新版本" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/hei-tang/id1157354886?mt=8"]];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)loadNewData
{
    [self getHomeData];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 结束刷新
//        [self.homeTableView.mj_header endRefreshingWithCompletionBlock:^{
//            //NSLog(@"loadNewData");
//            
//        }];
//    });
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isTop == YES) {
         [self homeInitialization];
    }
    
    
    //[self.homeTableView startRefresh:self Action:@selector(loadNewData)];
    
   

    //[self getHomeData];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
#pragma mark - 创建搜索框

- (void)createSearchTitle{
    
    
   ZRSearchView * searchView  =  [[ZRSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.55, 28)];
    _searchView = searchView;
    
    self.navigationItem.titleView = searchView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else{
        return _model.businessMsg.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"";
    }else{
        return @"";
    }
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

      [sectionView setBackgroundColor:R_G_B_16(0xfafafa)];

      [sectionView addSubview:label];

      [label mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(sectionView.mas_left).offset(12);
          make.centerY.equalTo(sectionView.mas_centerY);
      }];
    
       return sectionView;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * productCell = @"ProductCell";
    static NSString * advertisementCell = @"advertisementCell";
    
    switch (indexPath.section) {
        case 0:
        {
            ZRHomeCellOne * cellOne = [tableView dequeueReusableCellWithIdentifier:advertisementCell];
            if (cellOne == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellOne class]) owner:self options:nil];
                cellOne = [nibs lastObject];
            }
        
            cellOne.selectionStyle = UITableViewCellSelectionStyleNone;
            ZRExtensionModel * extensionOne;
            ZRExtensionModel * extensionTwo;
            if (_model.extension.count>0) {
                extensionOne  = _model.extension[0];
                extensionTwo  = _model.extension[1];
            }else{
                extensionOne.img = @"tu";
                extensionTwo.img = @"tu";
            }
 
            
            [cellOne createAdvertisementAndImgOne:extensionOne.img AndImgTwo:extensionTwo.img];
            WS(ws)
            cellOne.imgViewClick = ^(NSInteger index){
                if (index == 1) {
                    //超市
                    [CustomHudView dismiss];
                    ZRSupermarketController * supermarketVC = [[ZRSupermarketController alloc] init];
                    
                    [ws.navigationController pushViewController:supermarketVC animated:YES];
                }else{
                    //午餐
                    ZROrderingDetailsController * detailsVC = [[ZROrderingDetailsController alloc] init];
                    detailsVC.isLunch = YES;
                    [CustomHudView dismiss];
                    [ws.navigationController  pushViewController:detailsVC animated:YES];
                }
            };
            return cellOne;
        }
            break;
        case 1:
        {
//            ZRHomeCellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:productCell];
            
            if (!_cellTwo) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZRHomeCellTwo class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:productCell];
                _cellTwo = YES;
            }
            
            ZRHomeCellTwo * cellTwo = [tableView dequeueReusableCellWithIdentifier:productCell];
            
            
//            if (cellTwo == nil) {
//                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
//                cellTwo = [nibs lastObject];
//            }
            cellTwo.model = _model.businessMsg[indexPath.row];
            cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
            return cellTwo;
        }
            break;
        default:
            break;
    }
    return nil;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZRProductDetailsController * detailsCV = [[ZRProductDetailsController alloc] init];
    
    ZRBusinessModel * model = _model.businessMsg[indexPath.row];
    detailsCV.businessId = model.businessId;
    detailsCV.regionName = model.regionName;
    detailsCV.title = model.name;
    
    [self.navigationController pushViewController:detailsCV animated:YES];
    
    
}

#pragma mark -- 监听滑动距离
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 0) {
        
        _isTop = NO;
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        [self.navigationController.navigationBar lt_setBackgroundColor:[NAVCOLOR colorWithAlphaComponent:alpha]];
        [_leftBtn setTitleColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"gouwuche-1"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"jiantou-hong"] forState:UIControlStateNormal];
    } else {
        _isTop = YES;
        [self homeInitialization];
    }
}

#pragma mark -- 初始化
- (void)homeInitialization{
     [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [_leftBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
     [self.navigationController.navigationBar lt_setBackgroundColor:[NAVCOLOR colorWithAlphaComponent:0]];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     [_rightBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
}

#pragma mark -- 创建左按钮

- (void)createNavLeftBtn{
    
    UIButton * leftBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0,50, 44) ImageName:nil Target:self Action:@selector(chageCity) Title:@"Edmonton"];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn = leftBtn;
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:Font_BtnTitle];
    [self.leftBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];

    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,40, 0, 0)];
    [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-35, 0, 0)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -- 创建右按钮
- (void)createNavRightBtn{
//    UIButton * rightBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(shoppingCart) Title:nil];
//    _rightBtn = rightBtn ;
//    
//    [rightBtn setImage:[UIImage imageNamed:@"gouwuche-1"] forState:UIControlStateNormal];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark -- 左按钮点击事件

- (void)chageCity{
    //NSLog(@"点击左按钮");
}

#pragma mark -- 右按钮点击事件

- (void)shoppingCart{
    //NSLog(@"点击右按钮");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



#pragma mark -- 网络请求

- (void)getHomeData{
    WS(ws)
    
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    
    [ZRHomePageRequst requestGetAppHomePageWithLongitude:address.Longitude andLatitude:address.Latitude andSuccess:^(NSMutableArray *marr) {
        
        
        ZRHomeDataModel * model =marr[0];
        
        _model = model;
        
        ws.homeTableView.delegate = ws;
        ws.homeTableView.dataSource = ws;
        // 结束刷新
        [ws.homeTableView.mj_header endRefreshingWithCompletionBlock:^{
            //NSLog(@"loadNewData"); 
            [ws setUpButtons];
            [ws.homeTableView reloadData];
            ws.homeTableView.contentOffset = CGPointMake(0, 0);
        }];

        [CustomHudView dismiss];
        [self.homeTableView reloadData];
        
       
    } andFailure:^(id error) {
        //NSLog(@"%@",error);
        [ws.homeTableView.mj_header endRefreshing];
        [CustomHudView dismiss];
        ZRErrorController * errorVC = [[ZRErrorController alloc] init];
        errorVC.isMeiWang = YES;
        
        errorVC.clickBtn = ^(){
            [CustomHudView show];
            
            [ws getHomeData];
        };
        
        [ws presentViewController:errorVC animated:YES completion:^{
            
        }];
    }];
}


-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
