//
//  ZRAddressViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

// 收货地址
#import "ZRAddressViewController.h"
#import "ZRAddressTableViewCell.h"
#import "ZRAddView.h"
#import "ZRNewAddressViewController.h"
#import "ZRAlterAddressViewController.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUserAddressModel.h"
@interface ZRAddressViewController ()<UITableViewDelegate, UITableViewDataSource, alterAddressDelegate, newAddressDelegate>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * array;


@end

@implementation ZRAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:RGBCOLOR(240, 240, 240)];
        [self.view addSubview:_tableView];
        UIView * view = [UIView new];
        _tableView.tableFooterView = view;
        ZRAddView * addView = [[ZRAddView alloc] initWithFrame:CGRectMake(0, _tableView.frame.origin.y + _tableView.frame.size.height, ScreenWidth, 50)];
        [addView setBackgroundColor:[UIColor whiteColor]];
        [addView.clearButton addTarget:self action:@selector(actionAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@"收货地址"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
//    [self setData];
    [self addHeaderRefresh];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    
}
- (void)addHeaderRefresh
{
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        self.page = 1;
////        self.isUpLoading = YES;
////        NSString * pageStr = [NSString stringWithFormat:@"%ld", self.page];
////        [self requestDataList:pageStr];
//        [self setData];
//    }];
//    [self.tableView.mj_header beginRefreshing];
    
    WS(ws)
    [self.tableView startRefreshWithCallback:^{
        [ws setData];
        
    }];
}
- (void)setData
{
    self.array = [NSMutableArray array];
    /*
     @property (nonatomic, copy)NSString * id;
     @property (nonatomic, copy)NSString * name;
     @property (nonatomic, copy)NSString * phone;
     @property (nonatomic, assign)int gender;
     @property (nonatomic, copy)NSString * longitude;
     @property (nonatomic, copy)NSString * latitude;
     @property (nonatomic, copy)NSString * address;
     @property (nonatomic, assign)int isdefault;
     */
    WS(weakSelf);
    [ZRUserInterfaceModel getUserAddressCallBack:^(NSArray *result, NSString *isLoginStr, NSString *code) {

        for (NSDictionary * dic in result) {
            ZRUserAddressModel * model = [ZRUserAddressModel userWithDict:dic];
            [weakSelf.array addObject:model];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        // 如果收获地址只有一个, 第一次添加的收货地址为默认收货地址
        if (result.count == 1) {
            [self settingUserDefaultAddress:self.array];
        }
        [weakSelf.tableView reloadData];
    }];
}
// 如果收获地址只有一个, 第一次添加的收货地址为默认收货地址
- (void)settingUserDefaultAddress:(NSMutableArray *)array
{
    ZRUserAddressModel * model = [array objectAtIndex:0];
    model.isdefault = 1;
    NSString * ID = model.addressId;
    NSString * name = model.name;
    NSString * phone = model.phone;
    NSString * longitude = model.longitude;
    NSString * latitude = model.latitude;
    NSString * address = model.address;
    NSString * gender = [NSString stringWithFormat:@"%d", model.gender];
    NSString * Isdefault = [NSString stringWithFormat:@"%d", model.isdefault];
    [ZRUserInterfaceModel updateReceiptAddressWithID:ID Name:name Phone:phone Longitude:longitude Latitude:latitude Address:address Gender:gender Isdefault:Isdefault UserUpdateAddressCallBack:^(NSString *message) {
        //NSLog(@"%@", message);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * addressCellID = @"addressCellID";
    ZRAddressTableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    if (tableViewCell == nil) {
        tableViewCell = [[ZRAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressCellID];
    }
    tableViewCell.model = [self.array objectAtIndex:indexPath.row];
    tableViewCell.selectButton.tag = indexPath.row;
    [tableViewCell.selectButton addTarget:self action:@selector(addressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    return tableViewCell;
}
- (void)addressSelectButton:(UIButton *)sender
{
//    sender.selected = !sender.selected;
    for (NSInteger i = 0; i < self.array.count; i++) {
        if (i == sender.tag) {
            ZRUserAddressModel * model = [self.array objectAtIndex:i];
            model.isdefault = 1;
            NSString * ID = model.addressId;
            NSString * name = model.name;
            NSString * phone = model.phone;
            NSString * longitude = model.longitude;
            NSString * latitude = model.latitude;
            NSString * address = model.address;
            NSString * gender = [NSString stringWithFormat:@"%d", model.gender];
            NSString * Isdefault = [NSString stringWithFormat:@"%d", model.isdefault];
            
            dispatch_queue_t queue = dispatch_queue_create("com.pj.address", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                [ZRUserInterfaceModel updateReceiptAddressWithID:ID Name:name Phone:phone Longitude:longitude Latitude:latitude Address:address Gender:gender Isdefault:Isdefault UserUpdateAddressCallBack:^(NSString *message) {
                    //NSLog(@"%@", message);
                }];
            });
            dispatch_barrier_async(queue, ^{
                //NSLog(@"拦截");
            });
        } else {
            ZRUserAddressModel * model = [self.array objectAtIndex:i];
            model.isdefault = 0;
        }
    }
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRAlterAddressViewController * alterAddressVC = [[ZRAlterAddressViewController alloc] init];
    alterAddressVC.delegate = self;
    alterAddressVC.model = [self.array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:alterAddressVC animated:YES];
}
- (void)alterSuccess
{
    [self setData];
}
- (void)actionAddNewAddress
{
    WS(ws)
    if (self.array.count == 10) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"最多只能添加10条地址" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [ws dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ws dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:ok];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        ZRNewAddressViewController * newAddressVC = [[ZRNewAddressViewController alloc] init];
        newAddressVC.delegates = self;
        [self.navigationController pushViewController:newAddressVC animated:YES];
    }
}
- (void)newAddress
{
    [self setData];
}
// tableView编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZRUserAddressModel * model = [self.array objectAtIndex:indexPath.row];
        NSString * businessId = model.addressId;
        
        WS(ws)
        [ZRUserInterfaceModel delReceiptAddressWithId:businessId CallBack:^(NSString *message) {
            if ([message isEqualToString:@"success"]) {
                [AlertText showAndText:@"删除成功"];
                [ws.array removeObjectAtIndex:indexPath.row];
//                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
                [tableView reloadData];
            } else {
                [AlertText showAndText:@"删除失败"];
            }
            
        } Failure:^(id error) {
            [AlertText showAndText:@"删除失败"];
        }];
    }
}
- (void)deleteAddress
{
    [self addHeaderRefresh];
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
