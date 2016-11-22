//
//  ZROrderingController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingController.h"

#import "ZROrdeingCell.h"
#import "ZROrderingDetailsController.h"

#import "navTitleView.h"

#import "JSDropDownMenu.h"

#import "ZRLabelModel.h"

#import "ZRHomePageRequst.h"

#import "ZRLabelModel.h"

#import "ZROrderingNavController.h"
@interface ZROrderingController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) NSArray * cellData;
@property (nonatomic , assign) NSInteger page;
@end

@implementation ZROrderingController


-(void)setDataArr:(ZROrderingModel *)dataArr{
    _dataArr = dataArr;
    
    _cellData = dataArr.businessMsg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    [self setNavTitleView];
    
}

#pragma mark -- 设置标题
- (void)setNavTitleView {
    navTitleView * titleView = [[[NSBundle mainBundle] loadNibNamed:@"navTitleView" owner:self options:nil] lastObject];
    
    self.navigationItem.titleView = titleView;
    
    //点击标题,跳转定位界面
    titleView.navTitleClick = ^(){
        
        //NSLog(@"附近外卖,跳转定位界面");
    };
}

#pragma mark -- tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"LookProductCell";
    ZROrdeingCell *ordeingCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (ordeingCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrdeingCell class]) owner:self options:nil];
        ordeingCell = [nibs lastObject];
    }
    ZROrderingBusinessMsg * model = _cellData[indexPath.row];
    ordeingCell.businessModel = model;
    return ordeingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZROrderingDetailsController * detailsVC = [[ZROrderingDetailsController alloc] init];
    //...
    ZROrderingBusinessMsg * model = _cellData[indexPath.row];
    detailsVC.businessId = model.businessId;
    [self.navigationController  pushViewController:detailsVC animated:YES];
}


#pragma mark -- 点击筛选条件时 调用 发送请求

- (void)homeBaseViewControllerPostRequestWithDistance :(NSString *)distance andSort :(NSString*)sort andScreen :(NSString *)screen andLabel :(NSInteger)labelIndex{
    
    ZRLabelModel * label = _dataArr.label[labelIndex];
    
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestOrderingListQueryWithLongitude:address.Longitude  andLatitude:address.Latitude andDistance:distance andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows] andPage:[NSString stringWithFormat:@"%d",1] andSuccess:^(id success) {
        NSArray * successArr = success;
        if (successArr.count>0) {
            _cellData = successArr;
        }
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        
    }];
    
}

#pragma mark -- 点击头部8个按钮事件
- (void)homeBaseViewControllerHeaderClickWithBtn: (NSInteger) index{
    ZRLabelModel * model =  _dataArr.label[index];
    //发送请求
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestOrderingListWithLongitude:address.Longitude   andLatitude:address.Latitude andLabel:model.nav_id andSuccess:^(id success) {
        
        //品类
        NSMutableArray * labelMarr = [NSMutableArray array];
        for (ZRLabelModel * label in ws.dataArr.label) {
            if (label.nav_name != nil) {
                [labelMarr addObject:label.nav_name];
            }
        }
        NSDictionary * screeningDict = @{@"地理":@[@"3km之内",@"3km-5km",@"5km-8km"],@"品类":labelMarr,@"排序" : @[@"离我最近",@"评价最好",@"销量最高"],@"筛选":@[@"支持自取",@"在线支付",@"XX专送",@"优惠活动"]};
        
        
        ZROrderingNavController * navVC = [[ZROrderingNavController alloc]initWithTitleArr:nil andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序",@"筛选"]  andTitleImgArr:nil];
        navVC.model = success;
        navVC.title = @"附近外卖";
        [ws.navigationController pushViewController:navVC animated:YES];
        
    } andFailure:^(id error) {
        
    }];
}


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
