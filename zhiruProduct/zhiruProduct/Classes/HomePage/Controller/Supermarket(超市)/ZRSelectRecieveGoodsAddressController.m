//
//  ZRSelectRecieveGoodsAddressController.m
//  zhiruProduct
//
//  Created by nanding on 16/9/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectRecieveGoodsAddressController.h"
#import "ZRSelcetAcceptGoodsAddressCell.h"

#import "ZRUserInterfaceModel.h"
#import "ZRSelectAcceptAddressModel.h"

#import "ZRNewAddressViewController.h"

@interface ZRSelectRecieveGoodsAddressController ()<UITableViewDataSource, UITableViewDelegate, newAddressDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZRSelectAcceptAddressModel *selectAcceptAddressModel;

//保存所有历史地址
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZRSelectRecieveGoodsAddressController

#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZRBackgroundColor;
        
    }
    return _tableView;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择收货地址";
    // Do any additional setup after loading the view.
    [self createLeftBtn];
    //[self createRightShoppingCarBtn];
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //先判断是否登录
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        //用户未登录
        [ZRAlertControl notLoginAlert:self goLogin:^{
            
            //弹出登录页面
            ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
            ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
            
            [self presentViewController:nav animated:YES completion:nil];
            
            
        }];
    }else{
        [self.tableView startRefreshWithCallback:^{
            
            [self loadDatas];
            
        }];
    }

    
    
    
    
}


#pragma mark - Private methods
- (void)createLeftBtn{
    
    UIBarButtonItem * item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"cha"] highImage:[UIImage imageNamed:@"cha"]  target:self action:@selector(cancelBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}


//- (void)createRightShoppingCarBtn
//{
//    _shoppingCartBtn = [MyControl createButtonWithFrame:CGRectMake(5, 0, 50, 44) ImageName:nil Target:self Action:@selector(enterShoppingCar) Title:nil];
//    [_shoppingCartBtn setImage:ZRImage(@"gouwuche-1") forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_shoppingCartBtn];
//    
//    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
//}


-(void)setCurrentLocation:(NSString *)currentLocation
{
    _currentLocation = currentLocation;
    [self.tableView reloadData];
}

#pragma mark - click methods
- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  新增地址
 */
- (void)AddAddressClick:(UIButton *)sender
{
    ZRNewAddressViewController *newAddressVC = [[ZRNewAddressViewController alloc] init];
    newAddressVC.delegates = self;
    [self.navigationController pushViewController:newAddressVC animated:YES];
    
    
}

/**
 *  点击导航右侧购物车按钮，进入购物车页面
 */
- (void)enterShoppingCar
{
    
}


#pragma mark - newAddressDelegate methods
-(void)newAddress
{
    
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
        return self.dataArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRSelcetAcceptGoodsAddressCell *cell = [ZRSelcetAcceptGoodsAddressCell cellWithTable:self.tableView ForIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.curLocation = _currentLocation;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section == 0) {
        height = 40.0*SCREEN_HEIGHT/667;
    }else if (indexPath.section == 1){
        height = 75.0*SCREEN_HEIGHT/667;
    }
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0*SCREEN_HEIGHT/667;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat hei;
    if (section == 0) {
        hei = 0.1;
    }else{
        hei = 40*SCREEN_HEIGHT/667;
    }
    return hei;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30.0*SCREEN_HEIGHT/667)];
    UILabel *label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 30.0*SCREEN_HEIGHT/667)];
    label.textColor = RGBCOLOR(85, 85, 85);
    label.font = CustomFont(15);
    if (section==0) {
        label.text = @"当前地址";
        
    }else{
        label.text = @"历史地址";
        
    }
    [view addSubview:label];
    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *addAddressBtn;
    if (section==1) {
        addAddressBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0*SCREEN_HEIGHT/667)];
        [addAddressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
        [addAddressBtn setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
        addAddressBtn.titleLabel.font = CustomFont(15);
        addAddressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [addAddressBtn setImage:ZRImage(@"jia") forState:UIControlStateNormal];
        [addAddressBtn addTarget:self action:@selector(AddAddressClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        addAddressBtn = nil;
        
    }
    return addAddressBtn;
}



#pragma mark - 网络请求获取数据
- (void)loadDatas
{
    WS(ws)
    [ZRUserInterfaceModel getUserAddressCallBack:^(NSArray *result, NSString *isLoginStr, NSString *code) {
        [self.tableView.mj_header endRefreshing];
        
        if ([isLoginStr containsString:@"未登录"]) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还没有登录哦,请先登录" preferredStyle:UIAlertControllerStyleAlert];
            [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //弹出登录页面
                
                
            }];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"不要登录" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
        }else{
            ws.dataArray = [NSMutableArray arrayWithArray:result];
            [ws.tableView reloadData];
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:idx inSection:1];
                ZRSelcetAcceptGoodsAddressCell *cell = [ws.tableView cellForRowAtIndexPath:idxPath];
                _selectAcceptAddressModel = [ZRSelectAcceptAddressModel mj_objectWithKeyValues:obj];
                cell.historyAddress = _selectAcceptAddressModel;
                
            }];
 
        }
        
        
        
    }];
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
