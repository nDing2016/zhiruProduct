//
//  ZRTravalOrderViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTravalOrderViewController.h"
#import "ZRKeTravalOrederColl.h"
#import "ZRYiTravalOrderColl.h"
#import "ZRTuiTravalOrderColl.h"
#import "ZRQuanTravalOrderColl.h"
@interface ZRTravalOrderViewController ()//<senderDelegate>

@end

@implementation ZRTravalOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (NSArray *)setHeaderArray
{
    NSArray * array = [NSArray arrayWithObjects:@"可出行",@"已出行",@"退款单",@"全部订单", nil];
    return array;
}
- (void)setRegisterClass
{
    
    [self.collectionView registerClass:[ZRKeTravalOrederColl class] forCellWithReuseIdentifier:@"lxkechuxing"];
    [self.collectionView registerClass:[ZRYiTravalOrderColl class] forCellWithReuseIdentifier:@"lxyichuxing"];
    [self.collectionView registerClass:[ZRTuiTravalOrderColl class] forCellWithReuseIdentifier:@"lxtuikuandan"];
    [self.collectionView registerClass:[ZRQuanTravalOrderColl class] forCellWithReuseIdentifier:@"lxquanbu"];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZRKeTravalOrederColl  * coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"lxkechuxing" forIndexPath:indexPath];
        return coll;
    } else if (indexPath.row == 1){
        ZRYiTravalOrderColl  * coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"lxyichuxing" forIndexPath:indexPath];
        return coll;
    } else if (indexPath.row == 2) {
        ZRTuiTravalOrderColl  * coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"lxtuikuandan" forIndexPath:indexPath];
        return coll;
    } else {
        ZRQuanTravalOrderColl  * coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"lxquanbu" forIndexPath:indexPath];
        return coll;
    }
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
