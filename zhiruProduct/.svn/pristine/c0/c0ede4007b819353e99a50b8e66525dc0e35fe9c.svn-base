//
//  ZRLocationViewController.m
//  zhiruProduct
//
//  Created by pj on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  获取收货地址地图页面

#import "ZRLocationViewController.h"
#import "ZRNewAddressViewController.h"
#import "ZRAlterAddressViewController.h"
@interface ZRLocationViewController ()<UISearchResultsUpdating, UISearchBarDelegate, GMSMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong)UISearchController * searchController;
@property (nonatomic, strong)UITableView * tableView;


@property (nonatomic, strong) GMSMapView *googleMapView;
@property (nonatomic, strong) CLLocationManager *loacationManager;
//@property (nonatomic, strong) GMSMarker *melbourneMarker;
@property (nonatomic, strong) UIImageView *markerImgView;
@property (nonatomic, assign) BOOL firstLocationUpdate;



@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) CLLocationCoordinate2D coodinate;
@property (nonatomic, strong) GMSAddress *address;


@end

@implementation ZRLocationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createSearchController];
   
    //添加地图
    [self.view addSubview:self.googleMapView];
    [self.view addSubview:self.positionLabel];
    [self createNavigationRightButton];
    
}
- (void)createNavigationRightButton
{
    UIButton * rightButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 60, 40) ImageName:nil Target:self Action:@selector(userLocationConfirm) Title:@"确认"];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
- (void)userLocationConfirm
{
    if (_address.locality != NULL && _address.administrativeArea != NULL) {
        //将值传回上一个页面
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isMemberOfClass:[ZRNewAddressViewController class]]) {
                ZRNewAddressViewController *newAddressVC = (ZRNewAddressViewController *)vc;
                newAddressVC.longitude = [NSString stringWithFormat:@"%f",_coodinate.longitude];
                newAddressVC.latitude = [NSString stringWithFormat:@"%f",_coodinate.latitude];
                //街道
                newAddressVC.street = _address.thoroughfare;
                //城市
                newAddressVC.city = _address.locality;
                //AB 艾伯塔省
                newAddressVC.administrativeArea = _address.administrativeArea;
                //邮编
                newAddressVC.postalCodeStr = _address.postalCode;
            } else if ([vc isMemberOfClass:[ZRAlterAddressViewController class]]) {
                ZRAlterAddressViewController *newAddressVC = (ZRAlterAddressViewController *)vc;
                newAddressVC.longitudeAlter = [NSString stringWithFormat:@"%f",_coodinate.longitude];
                newAddressVC.latitudeAlter = [NSString stringWithFormat:@"%f",_coodinate.latitude];
                //街道
                newAddressVC.streetAlter = _address.thoroughfare;
                //城市
                newAddressVC.cityAlter = _address.locality;
                //邮编
                newAddressVC.postalCodeStrAlter = _address.postalCode;
                //AB 艾伯塔省
                newAddressVC.administrativeAreaAlter = _address.administrativeArea;
                
            }
            
            //        if ([vc isMemberOfClass:[ZRNewAddressViewController class]]) {
            //            ZRNewAddressViewController *newAddressVC = (ZRNewAddressViewController *)vc;
            //            newAddressVC.longitude = [NSString stringWithFormat:@"%f",_coodinate.longitude];
            //            newAddressVC.latitude = [NSString stringWithFormat:@"%f",_coodinate.latitude];
            //            //街道
            //            newAddressVC.street = _address.thoroughfare;
            //            //城市
            //            newAddressVC.city = _address.locality;
            //            //AB 艾伯塔省
            //            newAddressVC.administrativeArea = _address.administrativeArea;
            //            //邮编
            //            newAddressVC.postalCodeStr = _address.postalCode;
            //
            //
            //
            //
            //        } else {
            //            ZRAlterAddressViewController *newAddressVC = (ZRAlterAddressViewController *)vc;
            //            newAddressVC.longitude = [NSString stringWithFormat:@"%f",_coodinate.longitude];
            //            newAddressVC.latitude = [NSString stringWithFormat:@"%f",_coodinate.latitude];
            //            //街道
            //            newAddressVC.street = _address.thoroughfare;
            //            //城市
            //            newAddressVC.city = _address.locality;
            //            //AB 艾伯塔省
            //            newAddressVC.administrativeArea = _address.administrativeArea;
            //            //邮编
            //            newAddressVC.postalCodeStr = _address.postalCode;
            //        }
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
//- (void)createSearchController
//{
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.searchBar.placeholder = @"小区/写字楼/学校等";
//    self.searchController.dimsBackgroundDuringPresentation = YES;
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
//    self.searchController.searchBar.delegate = self;
//    [self.searchController.searchBar sizeToFit];
//    self.searchController.searchBar.frame = CGRectMake(40, 64, ScreenWidth-80, 44);
//    self.navigationItem.titleView = self.searchController.searchBar;
//}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //NSLog(@"1111");
}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    shouldShowSearchResults = YES;
//}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    shouldShowSearchResults = NO;
//}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    if (!shouldShowSearchResults) {
//        shouldShowSearchResults = YES;
//    }
//    [self.searchController.searchBar resignFirstResponder];
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除定位的大头针
    [_markerImgView removeFromSuperview];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //添加定位的大头针
    [self addMarker];
    [self.indicatorView startAnimating];
}

#pragma mark - 添加地图

- (void)addMarker
{
    _markerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 64+self.googleMapView.frame.size.height/2, 20, 40)];
    _markerImgView.center = CGPointMake(self.view.frame.size.width/2, self.googleMapView.frame.size.height/2+64-20);
    _markerImgView.image = [UIImage imageNamed:@"glow-marker"];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:_markerImgView];
}



#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    /**
     *    拿到授权发起定位请求
     
     */
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_loacationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     * 位置更新时调用
     */
    CLLocation *currentLocation = locations.firstObject;
    _googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:currentLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
    [_loacationManager stopUpdatingLocation];
}




#pragma  mark - Mapview Delegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    
    
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    [self.indicatorView startAnimating];
    //反向地理编码
    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:position.target completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        if (response.results) {
            GMSAddress *address = response.results[0];
            //NSLog(@"＝＝＝＝＝＝＝%@",address.thoroughfare);
            
            //_addressTextField.text = address.thoroughfare;
            
        }
    }];
}


- (void)geoSearchWithString:(NSString *)string{
    /**
     *  发起地理编码请求
     */
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyC6UdZfvOoEvOL9fFHQPfRawNix38ToRgM",[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    //网络请求时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 30;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [session GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //JSON解析
        NSMutableDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSDictionary *responseDic = responseObject;
        if ([responseDic[@"status"] isEqualToString:@"OK"]) {
            NSArray *returenArray = responseDic[@"results"];
            CLLocationCoordinate2D search ;
            NSDictionary *addressDic = returenArray[0];
            NSDictionary *locationDic = addressDic[@"geometry"][@"location"];
            search.longitude = [locationDic[@"lng"] floatValue];
            search.latitude = [locationDic[@"lat"] floatValue];
            //[_googleMapView animateToLocation:search];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark - 反地理编码
- (void)reverseGeocodeWithLatitude:(CGFloat)latitude WithLongitude:(CGFloat)longitude
{
    //    CLLocationDegrees lati = [latitude doubleValue];
    //    CLLocationDegrees longi = [longitude doubleValue];
    _coodinate = CLLocationCoordinate2DMake(latitude, longitude);
    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:_coodinate completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        if (response.results) {
            _address = response.results[0];
            //NSLog(@"反向地理编码＝＝＝＝＝＝＝%@",_address.thoroughfare);
            //当移动地图的时候，获取当前位置
            [self.indicatorView stopAnimating];
            self.positionLabel.text = [NSString stringWithFormat:@"%@,%@,%@,%@",_address.thoroughfare,_address.locality,_address.administrativeArea,_address.postalCode];
            //_addressTextField.text = address.thoroughfare;
            
        }
    }];
    
}



#pragma mark - 懒加载
-(GMSMapView *)googleMapView
{
    if (!_googleMapView) {
        
        _googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
        _googleMapView.delegate = self;
        _googleMapView.indoorEnabled = NO;
        _googleMapView.settings.rotateGestures = NO;
        _googleMapView.settings.tiltGestures = NO;
        _googleMapView.settings.myLocationButton = YES;
        _googleMapView.myLocationEnabled = YES;
        _loacationManager = [[CLLocationManager alloc] init];
        _loacationManager.delegate  = self;
        [_loacationManager requestWhenInUseAuthorization];
        
        [_googleMapView addObserver:self
                         forKeyPath:@"myLocation"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
        
        
        
    }
    return _googleMapView;
}


-(UILabel *)positionLabel
{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
        _positionLabel.textColor = RGBCOLOR(85, 85, 85);
        _positionLabel.font = CustomFont(15);
        [_positionLabel addSubview:self.indicatorView];
        
    }
    return _positionLabel;
}


-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.size = CGSizeMake(40, 40);
        _indicatorView.center = CGPointMake(SCREEN_WIDTH-50, 44/2);
    }
    return _indicatorView;
}



#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        _firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        _googleMapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}




- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
    //NSLog(@"idleAtCameraPosition");

    CLLocationCoordinate2D coodinate = position.target;

    //CLLocation *location = [[CLLocation alloc] initWithLatitude:coodinate.latitude longitude:coodinate.longitude];

    
    [self reverseGeocodeWithLatitude:coodinate.latitude WithLongitude:coodinate.longitude];


}





- (void)dealloc {
    
    [_googleMapView removeObserver:self
                        forKeyPath:@"myLocation"
                           context:NULL];
    
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
