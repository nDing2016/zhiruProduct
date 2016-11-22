//
//  ZRWeController.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWeController.h"
#import "ZRWeCell.h"
#import "ZRWeHeaderView.h"
#import "ZRWeDetailController.h"
#import <StoreKit/StoreKit.h>
#import "ZRSettingRequest.h"
#import "ZRVersionNumberModel.h"
@interface ZRWeController ()<UITableViewDelegate, UITableViewDataSource, SKStoreProductViewControllerDelegate>


@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSArray * array;

@end

@implementation ZRWeController

- (NSArray *)array
{
    if (_array == nil) {
        _array = [NSArray arrayWithObjects:@"清除缓存",@"喜欢我们,打分鼓励",@"我们有话说", nil];
    }
    return _array;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        ZRWeHeaderView * headerView = [[ZRWeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        _tableView.tableHeaderView = headerView;
        UIView * view = [UIView new];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"关于我们"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    ZRWeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRWeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.titleLabel setText:[self.array objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        float tmpSize = [[SDImageCache sharedImageCache] getSize];
        NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize/1000000] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize/1000];
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"确认清除%@", clearCacheName] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            float tmpSize = [[SDImageCache sharedImageCache] checkTmpSize];
            
            [[SDImageCache sharedImageCache] clearDisk];
            
//            [[SDImageCache sharedImageCache] clearMemory];
//            [AlertText showAndText:@"清除成功"];
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    } else if (indexPath.section == 2) {
        ZRWeController * weVC = [[ZRWeController alloc] init];
        [self.navigationController pushViewController:weVC animated:YES];
    } else if (indexPath.row == 1) {
        [self goToAppStore];
    } else if (indexPath.row == 2) {
        ZRWeDetailController * weVC = [[ZRWeDetailController alloc] init];
        [self.navigationController pushViewController:weVC animated:YES];

    }
//    if (indexPath.row == 0) {
//        //NSLog(@"喜欢我们, 打分鼓励");
//        
//    }
////    else if (indexPath.row == 1) {
////        NSLog(@"分享给朋友");
////    }
//    else if (indexPath.row == 1) {
//        //NSLog(@"我们有话说");
//    }
}
- (void)goToAppStore
{
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = self;
    [storeProductViewContorller loadProductWithParameters:
     @{SKStoreProductParameterITunesItemIdentifier : @"1157354886"} completionBlock:^(BOOL result, NSError *error) {
         if(error){
             [AlertText showAndText:@"跳转失败"];
         }else{
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }];
         }
     }];
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
