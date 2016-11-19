//
//  ZROrderingEvaluateController.m
//  zhiruProduct
//
//  Created by pj on 16/10/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingEvaluateController.h"
#import "ZREvaluateHeader.h"
#import "StarsView.h"

#import "PictureCollectionViewCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PictureAddCell.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>

#import "ZROrderingOrderRequest.h"

#define kMaxLength 15
#define kLength 150
@interface ZROrderingEvaluateController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MJPhotoBrowserDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UICollectionViewDelegateFlowLayout,ELCImagePickerControllerDelegate ,UIAlertViewDelegate >

@property (nonatomic , strong) NSMutableArray * itemsSectionPictureArray; //保存照片
@property (nonatomic , strong) UICollectionView * pictureCollectonView;
@property (nonatomic , strong) UIScrollView * myScrollView;

@property (nonatomic, strong)ZREvaluateHeader * evaluateHeader;

@property (nonatomic , strong) StarsView * overallView; // 总体
@property (nonatomic , strong) StarsView * tasteView;   // 口味
@property (nonatomic , strong) StarsView * serviceView; // 服务
@end

@implementation ZROrderingEvaluateController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"发表评论"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    [self createNavRightBtn];
    
    [self createsCrollView];
    
    [self createHeadView];
    
    [self createPictureView];
}
// 发表按钮
- (void)createNavRightBtn{
    //评论
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setTitle:@"发表" forState:UIControlStateNormal];
    informationCardBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [informationCardBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *fabiaoCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    self.navigationItem.rightBarButtonItems  = @[fabiaoCardItem];
}
// 点击发表按钮触发方法
- (void)enterehzFilesVC:(UIButton *)sender
{
//    NSLog(@"发表");
    if ([self checkComment]) {
        
        NSMutableArray * imgMarr = [NSMutableArray array];
        NSInteger i = 1;
        
        for (UIImage * img in self.itemsSectionPictureArray) {
            //图片压缩处理
            //NSData * imgData = [self resetSizeOfImageData:img maxSize:50];
            NSData * imgData = UIImageJPEGRepresentation(img, 0.1);
            
            NSDictionary *headPortraitDic = @{@"fileName":[NSString stringWithFormat:@"fileImg%ld",(long)i],@"imageData":imgData};
            [imgMarr addObject:headPortraitDic];
            i++;
        }
        [ZROrderingOrderRequest orderingCommentWithBusinessId:self.businessId Content:_evaluateHeader.textView.text Grade:[NSString stringWithFormat:@"%lf",_overallView.score] GradeOne:[NSString stringWithFormat:@"%lf",_tasteView.score] GradeTwo:[NSString stringWithFormat:@"%lf", _serviceView.score] CommentImgList:imgMarr CallBack:^(id success) {
            
            NSString * message = success;
            if ([message isEqualToString:@"success"]) {
                [AlertText showAndText:@"发表成功"];
                [self.navigationController popViewControllerAnimated:YES];
                _commentOK();
            } else {
                [AlertText showAndText:@"发表失败"];
            }
            
        } Failure:^(id error) {
            [AlertText showAndText:@"发表失败"];
        }];
    }

}
- (void)createsCrollView{
    UIScrollView * myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    myScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 200);
    
    _myScrollView = myScrollView;
    
    [self.view addSubview:myScrollView];
}
// 头部
- (void)createHeadView
{
    ZREvaluateHeader * headerView= [[ZREvaluateHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 405)];
    _evaluateHeader = headerView;
    [_myScrollView addSubview:headerView];
    
    StarsView *overallView = [[StarsView alloc] initWithStarSize:CGSizeMake(30, 30) space:5 numberOfStar:5 starHighLightImage:@"xingxing-hong" starNormalImage:@"xingxing-hei"];
    overallView.score = 1;
    overallView.frame = CGRectMake(75, 25, overallView.frame.size.width, overallView.frame.size.height);
    _overallView = overallView;
    [headerView.starBackView addSubview:overallView];
    
    StarsView *tasteView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xiaolian-huang" starNormalImage:@"xiaolian-hei"];
    tasteView.score = 1;
    tasteView.frame = CGRectMake(75, 10, tasteView.frame.size.width, tasteView.frame.size.height);
    _tasteView = tasteView;
    [headerView.pointBackView addSubview:tasteView];
    
    StarsView *serviceView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xiaolian-huang" starNormalImage:@"xiaolian-hei"];
    serviceView.score = 1;
    serviceView.frame = CGRectMake(75, 50, serviceView.frame.size.width, serviceView.frame.size.height);
    _serviceView = serviceView;
    [headerView.pointBackView addSubview:serviceView];
    
    [headerView.textView setDelegate:self];
}
#pragma mark - textView代理
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //    if ([textView.text isEqualToString:@"亲, 菜品的口味如何, 环境怎么样 , 服务满意么?"]) {
    //        textView.text = @"";
    //    }
    _evaluateHeader.textPlaceLabel.hidden = YES;
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        //        textView.text = @"亲, 菜品的口味如何, 环境怎么样 , 服务满意么?";
        //        textView.textColor = R_G_B_16(0x9a9a9a);
        _evaluateHeader.textPlaceLabel.hidden = NO;
        
    }
}
#pragma mark - 限制输入字符串长度
-(void)textViewDidChange:(UITextView *)textView{
    if (textView == self.evaluateHeader.textView) {
        NSString *toBeString = textView.text;
        
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage ;
        
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            
            UITextRange *selectedRange = [textView markedTextRange];
            
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length < kMaxLength) {
                    //                    textView.text = [toBeString substringToIndex:kMaxLength];
                    _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"还差%lu个字可以发表评论",kMaxLength - toBeString.length];
                }else if(toBeString.length > kMaxLength && toBeString.length < kLength){
                    _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"再输入%lu个字并上传3张图片,有机会赢得十倍积分",kLength - toBeString.length];
                }else if(toBeString.length > kLength && self.itemsSectionPictureArray.count <3){
                    
                    _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"再上传3张图片,有机会赢得十倍积分"];
                }else if(toBeString.length > kLength && self.itemsSectionPictureArray.count >=3){
                    _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"认真点评,十倍积分等你哦"];
                }
                //self.itemsSectionPictureArray
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        } // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        else{
            if (toBeString.length < kMaxLength)
            {
                //                textView.text = [toBeString substringToIndex:kMaxLength];
                
                //                    textView.text = [toBeString substringToIndex:kMaxLength];
                _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"还差%lu个字可以发表评论",kMaxLength - toBeString.length];
            }else if(toBeString.length > kMaxLength && toBeString.length < kLength){
                _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"再输入%lu个字并上传3张图片,有机会赢得十倍积分",kLength - toBeString.length];
            }else if(toBeString.length > kLength && self.itemsSectionPictureArray.count <3){
                _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"再上传3张图片,有机会赢得十倍积分"];
            }else if(toBeString.length > kLength && self.itemsSectionPictureArray.count >=3){
                _evaluateHeader.textFootLabel.text = [NSString stringWithFormat:@"认真点评,十倍积分等你哦"];
            }
            
        }
    }
    
}


#pragma mark - 创建照片选择器
- (void)createPictureView{
    
    //数组 保存图片
    self.itemsSectionPictureArray = [[NSMutableArray alloc] init];
    
    //设置 图片显示样式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(14.f, 5, 5.f, 5);
    
    //创建 UICollectionView
    self.pictureCollectonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_evaluateHeader.frame) + 25, ScreenWidth , 108) collectionViewLayout:layout];
    
    
    [self.pictureCollectonView registerClass:[PictureCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
    
    [self.pictureCollectonView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
    self.pictureCollectonView.scrollEnabled= NO;
    self.pictureCollectonView.backgroundColor = [UIColor whiteColor];
    
    self.pictureCollectonView.delegate = self;
    self.pictureCollectonView.dataSource = self;
    
    [_myScrollView addSubview:self.pictureCollectonView];
    _myScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_pictureCollectonView.frame));
    
}
#pragma mark - collectionView 调用方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsSectionPictureArray.count +1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        static NSString *addItem = @"addItemCell";
        
        UICollectionViewCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:addItem forIndexPath:indexPath];
        
        return addItemCell;
    }else
    {
        static NSString *identify = @"cell";
        PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        
        cell.imageView.image = self.itemsSectionPictureArray[indexPath.row];
        
        return cell;
    }
}

//用代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        if (self.itemsSectionPictureArray.count > 9) {
            return;
        }
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择", @"拍照", nil];
        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [sheet showInView:self.view];
    }else
    {
        NSMutableArray *photoArray = [[NSMutableArray alloc] init];
        for (int i = 0;i< self.itemsSectionPictureArray.count; i ++) {
            UIImage *image = self.itemsSectionPictureArray[i];
            
            MJPhoto *photo = [MJPhoto new];
            photo.image = image;
            PictureCollectionViewCell *cell = (PictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            photo.srcImageView = cell.imageView;
            [photoArray addObject:photo];
        }
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photoBrowserdelegate = self;
        browser.currentPhotoIndex = indexPath.row;
        browser.photos = photoArray;
        [browser show];
        
    }
}

//删除照片功能

-(void)deletedPictures:(NSSet *)set
{
    NSMutableArray *cellArray = [NSMutableArray array];
    
    for (NSString *index1 in set) {
        [cellArray addObject:index1];
    }
    
    if (cellArray.count == 0) {
        
    }else if (cellArray.count == 1 && self.itemsSectionPictureArray.count == 1) {
        NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.itemsSectionPictureArray removeObjectAtIndex:indexPathTwo.row];
        [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPathTwo]];
    }else{
        
        for (int i = 0; i<cellArray.count-1; i++) {
            for (int j = 0; j<cellArray.count-1-i; j++) {
                if ([cellArray[j] intValue]<[cellArray[j+1] intValue]) {
                    NSString *temp = cellArray[j];
                    cellArray[j] = cellArray[j+1];
                    cellArray[j+1] = temp;
                }
            }
        }
        
        for (int b = 0; b<cellArray.count; b++) {
            int idexx = [cellArray[b] intValue]-1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idexx inSection:0];
            
            [self.itemsSectionPictureArray removeObjectAtIndex:indexPath.row];
            [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    //修改 删除后的 collection Frame
    if (self.itemsSectionPictureArray.count <3) {
        
        self.pictureCollectonView.height = 108;
        
        
    }else if (self.itemsSectionPictureArray.count <6)
    {
        
        self.pictureCollectonView.height = 216;
        
    }else
    {
        
        self.pictureCollectonView.height = 324;
        
    }
    _myScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_pictureCollectonView.frame));
}
#pragma mark - 相册、相机调用方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //NSLog(@"点击了从手机选择");
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        elcPicker.maximumImagesCount = 9 - self.itemsSectionPictureArray.count;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        elcPicker.onOrder = NO;
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        elcPicker.imagePickerDelegate = self;
        //    elcPicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//过渡特效
        [self presentViewController:elcPicker animated:YES completion:nil];
        
    }else if (buttonIndex == 1)
    {
        
        //NSLog(@"点击了精美配图");
        
    }else if (buttonIndex == 2)
    {
        //NSLog(@"点击了拍照");
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            
            picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            //NSLog(@"模拟无效,请真机测试");
        }
    }
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    __weak ZROrderingEvaluateController *wself = self;
    [self dismissViewControllerAnimated:YES completion:^{
        BOOL hasVideo = NO;
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [images addObject:image];
                } else {
                    //NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
                if (!hasVideo) {
                    hasVideo = YES;
                    
                }
            } else {
                //NSLog(@"Uknown asset type");
            }
        }
        
        NSMutableArray *indexPathes = [NSMutableArray array];
        //ws = wself
        for (unsigned long i = wself.itemsSectionPictureArray.count; i < wself.itemsSectionPictureArray.count + images.count; i++) {
            [indexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [wself.itemsSectionPictureArray addObjectsFromArray:images];
        // 调整集合视图的高度
        [wself textViewDidChange:wself.evaluateHeader.textView];
        
        
        [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
            
            //--->根据 选中图片 动画效果 添加
            if (wself.itemsSectionPictureArray.count <3) {
                
                wself.pictureCollectonView.height = 108;
                
            }else if (wself.itemsSectionPictureArray.count <6)
            {
                
                wself.pictureCollectonView.height = 216;
                
            }else
            {
                
                wself.pictureCollectonView.height = 324;
                
            }
            
            _myScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_pictureCollectonView.frame));
            [wself.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            // 添加新选择的图片
            [wself.pictureCollectonView performBatchUpdates:^{
                [wself.pictureCollectonView insertItemsAtIndexPaths:indexPathes];
            } completion:^(BOOL finished) {
                if (hasVideo) {
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持视频发布" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }];
        }];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    
    [self.itemsSectionPictureArray addObject:image];
    __weak ZROrderingEvaluateController *wself = self;
    [self textViewDidChange:self.evaluateHeader.textView];
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
            if (wself.itemsSectionPictureArray.count <3) {
                
                wself.pictureCollectonView.height = 108;
                
            }else if (wself.itemsSectionPictureArray.count <6)
            {
                
                wself.pictureCollectonView.height = 216;
                
            }else
            {
                
                wself.pictureCollectonView.height = 324;
                
            }
            _myScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_pictureCollectonView.frame));
            [wself.view layoutIfNeeded];
        } completion:nil];
        
        [self.pictureCollectonView performBatchUpdates:^{
            [wself.pictureCollectonView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:wself.itemsSectionPictureArray.count - 1 inSection:0]]];
        } completion:nil];
    }];
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 效验

- (BOOL)checkComment{
    
    if (_evaluateHeader.textView.text.length>0) {
        return YES;
    } else{
        return NO;
    }
}
/**
 *  图片压缩
 *
 *  @param source_image 原图
 *  @param maxSize      限定图片大小
 *
 *  @return 返回处理后数据
 */
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}


// 导航条左按钮 事件
- (void)setLeftBtnClick{
    [self createNavWithTitle:nil andLeftImg:nil andLeftTitle:nil andRightImg:nil andRightTitle:nil andLeftClick:^{
        UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"确定取消发送么" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [alertV show];
    } andRightTitle:nil];
}

#pragma mark -- Alert代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //
    if (buttonIndex == 0) {
        [self.view endEditing:YES];
        //0.5秒后执行pop 防止键盘动画未执行完,导致键盘闪现
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }else{
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
