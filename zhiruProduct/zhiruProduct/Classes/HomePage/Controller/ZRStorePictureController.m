//
//  ZRStorePictureController.m
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStorePictureController.h"
#import "ZRPictureColl.h"
#import "ZRPhotosController.h"
#import "ZRHomePageRequst.h"
@interface ZRStorePictureController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ZRStorePictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"店铺环境"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
//    NSLog(@"pppp=%@", self.bussinesId);
    self.dataArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (ScreenWidth - 60) / 2;
    flowLayout.itemSize = CGSizeMake(width, width);
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ZRPictureColl class] forCellWithReuseIdentifier:@"cell"];
    
    [self addHeaderRefresh];
}

- (void)addHeaderRefresh
{
    [self.collectionView startRefreshWithCallback:^{
        [self getDataArray];
    }];
}

- (void)getDataArray
{
    [ZRHomePageRequst requestGetBusinessPhotosWithBusinessId:self.bussinesId CallBack:^(NSMutableArray *success) {
        [self.dataArray removeAllObjects];
        self.dataArray = success;
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } Failure:^(id error) {
        [AlertText showAndText:@"获取失败"];
    }];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置有多少和item
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZRPictureColl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
// 点击item触发方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
    ZRPhotosController * photosVC = [[ZRPhotosController alloc] init];
    photosVC.dataArray = self.dataArray;
    photosVC.page = indexPath.row;
    [self.navigationController pushViewController:photosVC animated:YES];
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
