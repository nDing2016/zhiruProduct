//
//  ZRStoreupShopController.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStoreupShopController.h"
#import "ZRHomeCellTwo.h"
#import "ZRUserStoreupRequest.h"
#import "ZRBusinessModel.h"


#import "ZRProductDetailsController.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRStoreupRootViewController.h"
@interface ZRStoreupShopController ()<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isUpLoading;

@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZRStoreupShopController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addHeaderRefresh];
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_tableView];
        UIView * view = [[UIView alloc] init];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.dataArray = [NSMutableArray array];
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
//    [self addHeaderRefresh];
    [self addFooterRefresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"storeupShop";
    ZRHomeCellTwo * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
        cell = [nib lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRProductDetailsController * productVC = [[ZRProductDetailsController alloc] init];
    ZRBusinessModel * model = [self.dataArray objectAtIndex:indexPath.row];
    productVC.businessId = model.businessId;
    ZRTabBarViewController * tabBar = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController * nav = tabBar.viewControllers[2];
    ZRStoreupRootViewController * storeVC = nav.viewControllers[1];
    [storeVC.navigationController pushViewController:productVC animated:YES];
}
- (void)addHeaderRefresh
{
    [self.tableView startRefreshWithCallback:^{
        self.page = 1;
        self.isUpLoading = YES;
        NSString * pageStr = [NSString stringWithFormat:@"%ld", (long)self.page];
        [self requestDataList:pageStr];
    }];
}
- (void)addFooterRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page++;
        self.isUpLoading = NO;
        NSString * pageStr = [NSString stringWithFormat:@"%ld", (long)self.page];
        [self requestDataList:pageStr];
    }];
}
- (void)requestDataList:(NSString *)pageStr
{
    [ZRUserStoreupRequest businessCCollectionWithRows:@"6" Page:pageStr BusinessCollectionCallBack:^(NSMutableArray * array, NSString * message) {
        if ([message isEqualToString:@"success"]) {
            if (self.isUpLoading == YES) {
                [self.dataArray removeAllObjects];
            }
            for (ZRBusinessModel * model in array) {
                [self.dataArray addObject:model];
            }
        } else {
            [AlertText showAndText:message];
        }
        if (self.dataArray.count == 0) {
            [self createImage];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } Failure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

// tableView编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZRBusinessModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSString * businessId = model.businessId;
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [ZRUserStoreupRequest delBusinessCollectionWithBusinessId:businessId CallBack:^(NSString *message) {
            if (self.dataArray.count == 0) {
                [self addHeaderRefresh];
            }
        } Failure:^(id error) {
            
        }];
    }
    [tableView reloadData];
}
// 添加暂无收藏图片
- (void)createImage
{
    UIImageView * img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:@"nostore"]];
    [self.view addSubview:img];
    WS(weakSelf);
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
    }];
}
//- (void)setShopState:(BOOL)shopState
//{
//    if (shopState == YES) {
//        [self addHeaderRefresh];
//    }
//}
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
