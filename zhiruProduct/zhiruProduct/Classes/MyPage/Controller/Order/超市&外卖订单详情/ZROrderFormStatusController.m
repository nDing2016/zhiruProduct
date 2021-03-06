//
//  ZROrderFormStatusController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderFormStatusController.h"
#import "ZROrderFormStatusCell.h"
#import "ZROrderDetailsRequest.h"
#import "ZRSuperOrderProcessModel.h"

@interface ZROrderFormStatusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZRSuperOrderProcessModel *processModel;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZROrderFormStatusController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单状态";
    [self.view addSubview:self.tableView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView startRefreshWithCallback:^{
        
        [self loadDatas];
        
    }];
    
}


#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR(250, 250, 250);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZROrderFormStatusCell *cell = [ZROrderFormStatusCell cellWithTable:tableView ForIndexPath:indexPath];
    cell.idxPath = indexPath;
    cell.status = self.dataArray.count-1;
    cell.orderId = self.orderIdStr;
    cell.processModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*SCREEN_HEIGHT/667;
}

#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 网络请求获取数据
- (void)loadDatas
{
    WS(ws)
    [ZROrderDetailsRequest requestForKaOrderProcessWithOrderId:self.orderIdStr Callback:^(id details, NSError *error) {
        [ws.tableView.mj_header endRefreshing];
        if (details) {
            for (id detail in details) {
                ws.processModel = [ZRSuperOrderProcessModel mj_objectWithKeyValues:detail];
                [ws.dataArray addObject:ws.processModel];
            }
        }
        
        [ws.tableView reloadData];
        
    }];
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
