//
//  ZRLookForTasteNavController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/1.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLookForTasteNavController.h"
#import "ZRHomeCellTwo.h"
#import "ZRHomePageRequst.h"
#import "ZRRegionModel.h"
#import "ZRLabelModel.h"
#import "ZRProductDetailsController.h"
#import "ZRHomePageRequst.h"
@interface ZRLookForTasteNavController ()

@property (nonatomic , strong) NSMutableArray * array;

@end

@implementation ZRLookForTasteNavController

- (NSMutableArray *)array{
    if (_array == nil) {
            _array = [NSMutableArray array] ;
    }

    return _array   ;
}


- (void)setModel:(ZRHomeNavModel *)model{
    _model = model;
    
    [self.array addObjectsFromArray:model.businessMsg];
//    [self.modelArr addObjectsFromArray: model.businessMsg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * productCell = @"LookProductCell";
    ZRHomeCellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:productCell];
    
    if (cellTwo == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
        cellTwo = [nibs lastObject];
    }
    cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
    cellTwo.model = self.array[indexPath.row];
    return cellTwo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRProductDetailsController * detailVC = [[ZRProductDetailsController alloc] init];
    ZRBusinessModel * model = self.array[indexPath.row];
    detailVC.regionName = model.regionName;
    detailVC.businessId = model.businessId;
    detailVC.title = model.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

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
    if (_type == 0) {
        //丽人  requestGetLiRenListWithLongitude
        
        [ZRHomePageRequst requestGetLiRenListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
            [ws.array removeAllObjects];
            //NSLog(@"成功");
            [ws.array addObjectsFromArray:success];
            
            [ws.myTableView reloadData];
        } andFailure:^(id error) {
            
            //NSLog(@"失败");
            
        }];

    } else if(_type == 1){
        //yule  requestGetYuLeListWithLongitude
        [ZRHomePageRequst requestGetYuLeListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
            [ws.array removeAllObjects];
            //NSLog(@"成功");
            [ws.array addObjectsFromArray:success];
            
            [ws.myTableView reloadData];
        } andFailure:^(id error) {
            
            //NSLog(@"失败");
            
        }];
    }else{
        [ZRHomePageRequst requestGetFindtasteListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
            [ws.array removeAllObjects];
            //NSLog(@"成功");
            [ws.array addObjectsFromArray:success];
            
            [ws.myTableView reloadData];
        } andFailure:^(id error) {
            
            //NSLog(@"失败");
            
        }];
    }
   
}

//- (void)homeBaseViewControllerPostRequestWithDistance :(NSString *)distance andSort :(NSString*)sort andScreen :(NSString *)screen andLabel :(NSInteger)labelIndex{
//    
//    //地域
//    NSArray * regionArr = _model.region;
//    ZRRegionModel * region = regionArr[self.currentData1Index];
//    NSLog(@"%@",region.region_name);
//    //标签
//    NSArray * labelArr = _model.label;
//    ZRLabelModel * label = labelArr[self.currentData2Index];
//    
//    WS(ws)
//    [ZRHomePageRequst requestGetFindtasteListWithLongitude:ZRLongitude andLatitude:ZRLatitude andRegionId:region.region_id andCity:@"" andNavId:@"" andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
//        
//        NSLog(@"成功");
//        ws.modelArr = success;
//        //        NSLog(@"%ld",ws.modelArr.count);
//        [ws.myTableView reloadData];
//    } andFailure:^(id error) {
//        
//        NSLog(@"失败");
//        
//    }];
//    
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
