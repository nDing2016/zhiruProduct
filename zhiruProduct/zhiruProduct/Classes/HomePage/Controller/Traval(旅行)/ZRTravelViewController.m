//
//  ZRTravelViewController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTravelViewController.h"
#import "ZRSegmentView.h"
#import "ZRSupermarketCell.h"

@interface ZRTravelViewController ()<ZRSegmentViewDelegate>

@property (nonatomic, strong) ZRSegmentView *segmentView;

@end

static NSString *itemID =@"itemID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";
@implementation ZRTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"旅行";
}


#pragma mark - 实现父类的方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else
        return 4;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        
        
        UIView *header;
        if (indexPath.section == 2){
            header = [self setUpSegmentView];
            
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, view.height)];
            scrollView.contentSize = CGSizeMake(header.width, 0);
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.bounces = NO;
            [view addSubview:scrollView];
            [scrollView addSubview:header];
        }
        header.backgroundColor = [UIColor whiteColor];
        return view;
        
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
       if (indexPath.section == 2) {
           footer.backgroundColor = [UIColor whiteColor];           
           UIButton *checkAllBtn = (UIButton *)[self setUpBtnWithCheckAll:CGPointMake(SCREEN_WIDTH/2,  55/2) WithSupermarketModel:nil];
           checkAllBtn.tag = kTravel_CheckAll;
           [footer addSubview:checkAllBtn];
        }
        
        return footer;
        
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZRSupermarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell setNeedsDisplay];
    
    if (indexPath.section == 0) {
        //轮播图
        NSArray * imgUrl = @[@"http://img11.360buyimg.com/cms/jfs/t196/241/2413424678/109726/34738058/53cf6e32Na0cbe3e5.jpg",@"http://img11.360buyimg.com/cms/g16/M00/0C/0A/rBEbRlOK07EIAAAAAAPXHfjijrkAACZxAMOZPwAA9c1025.jpg"];
        [self setUpAdView:imgUrl SuperView:cell];
    }else if (indexPath.section == 1){
        NSArray *arr = @[@[ZRImage(@"l_jiaguoyou"),@"加国游",@"1"],@[ZRImage(@"l_meizhouyou"),@"美洲游",@"0"],@[ZRImage(@"l_ouzhouyou"),@"欧洲游",@"0"]];
        cell.travelArr = arr[indexPath.item];
        
        
    }else{
        NSArray *arr = @[ZRImage(@"hanbao"),@"北京/天津/沈阳/青岛直飞新加坡6天往返含税机票",@"$ 1050/人",@"👍5212"];
        cell.cellIndex = indexPath.item;
        cell.categoryTravelArr = arr;
        
    }
    
    return cell;
}




/**
 *  每个section的header的height
 *
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 0);
        
    }else if (section == 1){
        return CGSizeMake(SCREEN_WIDTH, 5);
    }else
        return CGSizeMake(SCREEN_WIDTH, 40);
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size;
    if (section == 2) {
        size = CGSizeMake(SCREEN_WIDTH, 55);
    }else if (section == 1){
        size = CGSizeMake(SCREEN_WIDTH, 5);
    }else if (section == 0){
        size = CGSizeMake(SCREEN_WIDTH, 0);
    }
    return size;
}


/**
 *  cell的size
 *
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 180);
    }else if (indexPath.section == 1){
        return CGSizeMake((SCREEN_WIDTH-2)/3, 110);
    }else
        return CGSizeMake(SCREEN_WIDTH/2, 180);
}

/**
 *  最小行距
 *
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

/**
 *  最小列间距
 *
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }else
        return 0;
}








#pragma mark - Private methods
- (id)setUpSegmentView
{
    NSArray *arrar = [NSArray arrayWithObjects:@"全部",@"跟团游",@"自由行",@"定制游",@"拼车游",@"游轮游", nil];
    _segmentView = [[ZRSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*arrar.count/5, 30)];
    _segmentView.backgroundColor = [UIColor clearColor];
    _segmentView.tag = 21;
    _segmentView.textNormalColor = [UIColor blackColor];
    _segmentView.textSeletedColor = [UIColor blueColor];
    _segmentView.delegate = self;
    _segmentView.linColor = [UIColor blueColor];
    _segmentView.textFont = [UIFont systemFontOfSize:16];
    [_segmentView loadNomalTitleArray:arrar];
    
    
    return _segmentView;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - ZRSegmentViewDelegate methods
-(void)segmentView:(ZRSegmentView *)segmentView index:(NSInteger)index
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
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
