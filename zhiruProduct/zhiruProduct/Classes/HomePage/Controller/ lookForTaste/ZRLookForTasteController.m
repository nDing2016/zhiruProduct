//
//  ZRLookForTasteController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLookForTasteController.h"
#import "ZRHomeCellTwo.h"
#import "ZRProductDetailsController.h"
#import "ZRBusinessModel.h"
#import "ZRLabelModel.h"
#import "ZRHomePageRequst.h"
#import "ZRLookForTasteNavController.h"

#import "ZRRegionModel.h"
#import "ZRLabelModel.h"

@interface ZRLookForTasteController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , assign) NSInteger page;
@end

@implementation ZRLookForTasteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
 
    
    WS(ws)
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        //网络请求
        [ws startRefresh];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
       //下拉加载最新
    WS(ws)
    [self.myTableView startRefreshWithCallback:^{
        ws.page = 1;
        //网络请求
        [ws startRefresh];
    }];
}

-(void)setModel:(ZRHomeNavModel *)model{
    _model = model;
    [self.modelArr addObjectsFromArray: model.businessMsg];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * productCell = @"LookProductCell";
    ZRHomeCellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:productCell];
    
    if (cellTwo == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
        cellTwo = [nibs lastObject];
    }
    
    cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cellTwo.model = self.modelArr[indexPath.row];
    return cellTwo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRProductDetailsController * detailVC = [[ZRProductDetailsController alloc] init];
    ZRBusinessModel * model = self.modelArr[indexPath.row];
    detailVC.regionName = model.regionName;
    detailVC.businessId = model.businessId;
    detailVC.title = model.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击筛选条件工具条
- (void)screenToolClick{
    
    
    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];
    //NSLog(@"%@",region.region_name);
    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
    
   
    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
    
    if (self.currentData4Index == 2) {
        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
    }
    
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
        [ws.modelArr removeAllObjects];
        //NSLog(@"成功");
        [ws.modelArr addObjectsFromArray:success];

        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        //NSLog(@"失败");
        
    }];
}


- (void)homeBaseViewControllerHeaderClickWithBtn: (NSInteger) index{
    
    //地域
//    NSArray * regionArr = _model.region;
//    ZRRegionModel * region = regionArr[self.currentData1Index];
//    //NSLog(@"%@",region.region_name);
//    //标签
//    NSArray * labelArr = _model.label;
//    ZRLabelModel * label = labelArr[index];
//    
//    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
//    
//    
//    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
//    
//    if (self.currentData4Index == 2) {
//        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
//    }
//    
//    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    NSArray * labelArr = self.model.label;
    ZRLabelModel * labelModel = labelArr[index + 1];
    
    WS(ws)
    [CustomHudView show];
    //跳转
    [ZRHomePageRequst requestGetFindtasteIndexWithLongitude:_longitude andLatitude:_latitude andLabel:labelModel.nav_id andSuccess:^(id success) {
        
        ZRHomeNavModel * model = ws.model;
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
        
        
        //        NSDictionary * screeningDict = [NSDictionary dictionaryGetScreeningWithModel:ws.model isPaixu:YES];
        NSDictionary * screeningDict = @{@"地理":regionMarr, @"品类":labelMarr , @"排序":@[@"智能排序,"@"离我最近",@"评价最好",@"设施最佳",@"环境最佳",@"服务最佳"]};
        
        ZRLookForTasteNavController * navVC = [[ZRLookForTasteNavController alloc]  initWithTitleArr:nil andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:nil];
        navVC.title = @"寻味";
        navVC.model = success[0];
        navVC.latitude = _latitude;
        navVC.longitude = _longitude;
        [ws.navigationController pushViewController:navVC animated:YES];
        [CustomHudView dismiss];


    } andFailure:^(id error) {
        
        //NSLog(@"失败");
        [CustomHudView dismiss];
    }];

    
  
    
}






- (void)startRefresh{

    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];
    //NSLog(@"%@",region.region_name);
    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
    
    
    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
    
    if (self.currentData4Index == 2) {
        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
    }
    
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:[NSString stringWithFormat:@"%ld",_page ] andSuccess:^(id success) {
        
        NSArray * arr = success;
        if (arr.count == 0) {
            [ws.myTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [ws.myTableView.mj_header endRefreshing];
            [ws.myTableView.mj_footer endRefreshing];
            if (_page == 1) {
                ws.modelArr = nil;
                
            }
            [ws.modelArr addObjectsFromArray:success];
            _page ++;

        }
        //NSLog(@"成功");
        
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
         [ws.myTableView.mj_header endRefreshing];
        //NSLog(@"失败");
        [ws.myTableView.mj_footer endRefreshing];
    }];
    
}
//lr dk dz zs
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
