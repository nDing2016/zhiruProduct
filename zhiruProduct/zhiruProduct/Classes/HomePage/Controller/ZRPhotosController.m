//
//  ZRPhotosController.m
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPhotosController.h"
#import "ZRPhotosModel.h"
#import "ZRPhotosCell.h"
@interface ZRPhotosController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ZRPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"图片详情"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setContentOffset:CGPointMake(ScreenWidth * self.page, 0)];
    [self.collectionView setBounces:NO];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ZRPhotosCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
//    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
//    [scrollView setDelegate:self];
//    [scrollView setContentSize:CGSizeMake(ScreenWidth * self.dataArray.count, ScreenHeight - 64)];
//    [scrollView setPagingEnabled:YES];
//    [scrollView setContentOffset:CGPointMake(ScreenWidth * self.page, 64) animated:NO];
//    [scrollView setBounces:NO];
//    [scrollView setBackgroundColor:[UIColor blackColor]];
//    
//    
//    for (int i = 0; i < self.dataArray.count; i++) {
//        
//        ZRPhotosModel * model = [self.dataArray objectAtIndex:i];
//        UIImage * image = [UIImage getImageFromURL:model.img_url];
//        CGSize size = image.size;
//        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 64, ScreenWidth, ScreenWidth / size.width * size.height)];
//        [imgView setImage:image];
//        [scrollView addSubview:imgView];
//        
//        UILabel * imgName = [[UILabel alloc] initWithFrame:CGRectMake(20 + ScreenWidth * i, self.view.frame.size.height - 50, ScreenWidth - 40, 25)];
//        [imgName setBackgroundColor:[UIColor clearColor]];
//        [imgName setTextColor:[UIColor whiteColor]];
//        [imgName setFont:[UIFont systemFontOfSize:16]];
//        [imgName setText:model.describe];
//        [scrollView addSubview:imgName];
//        
//        UILabel * createTime = [[UILabel alloc] initWithFrame:CGRectMake(20 + ScreenWidth * i, self.view.frame.size.height - 25, ScreenWidth - 40, 25)];
//        [createTime setBackgroundColor:[UIColor clearColor]];
//        [createTime setTextColor:[UIColor whiteColor]];
//        [createTime setFont:[UIFont systemFontOfSize:16]];
//        [createTime setText:model.create_date];
//        [scrollView addSubview:createTime];
//    }
//    [self.view addSubview:scrollView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置有多少和item
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZRPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
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
