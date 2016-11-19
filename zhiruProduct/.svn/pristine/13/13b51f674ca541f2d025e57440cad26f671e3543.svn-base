//
//  ZRMapViewController.m
//  zhiruProduct
//
//  Created by nanding on 16/9/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMapViewController.h"
#import "ZRMyLocation.h"

@interface ZRMapViewController ()<GMSMapViewDelegate, CLLocationManagerDelegate>

/**old

@property (nonatomic, strong) GMSMapView *mapView;

@property (nonatomic, assign) BOOL firstLocationUpdate;

@property (nonatomic, strong) UIImageView *markerImgView;


@property (nonatomic, strong) GMSMarker *melbourneMarker;

@property (nonatomic, strong) GMSGeocoder *myGeocoder;
 **/




@property (nonatomic, strong) GMSMapView *googleMapView;
@property (nonatomic, strong) CLLocationManager *loacationManager;
@property (nonatomic, strong) GMSMarker *melbourneMarker;

@end

@implementation ZRMapViewController


#pragma mark - 懒加载
-(GMSMapView *)googleMapView
{
    if (!_googleMapView) {
        
        _googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _googleMapView.delegate = self;
        _googleMapView.indoorEnabled = NO;
        _googleMapView.settings.rotateGestures = NO;
        _googleMapView.settings.tiltGestures = NO;
        _googleMapView.settings.myLocationButton = YES;
        _googleMapView.myLocationEnabled = YES;
        _loacationManager = [[CLLocationManager alloc] init];
        _loacationManager.delegate  = self;
        [_loacationManager requestWhenInUseAuthorization];
        
    }
    return _googleMapView;
}


#pragma mark - lifeCycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"地图";
    [self.view addSubview:self.googleMapView];
    //[self geoSearchWithString:@"加拿大埃德蒙顿"];
    
    _melbourneMarker.map = nil;
    _melbourneMarker = [[GMSMarker alloc] init];
    _melbourneMarker.title = @"Melbourne";
    _melbourneMarker.snippet = @"Population: 4,169,103";
    _melbourneMarker.position = CLLocationCoordinate2DMake(53.518463, -113.517280
);
    _melbourneMarker.map = self.googleMapView;
    
    
//    //test
//    [self reverseGeocodeWithLatitude:53.544389 WithLongitude:-113.4909267];
//    [self geoSearchWithString:@"10425 100 Ave NW,Edmonton,AB T5J 0A3"];
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
    CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake(latitude, longitude);
    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:coodinate completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        if (response.results) {
            GMSAddress *address = response.results[0];
            //NSLog(@"＝＝＝＝＝＝＝%@",address.thoroughfare);
            //_addressTextField.text = address.thoroughfare;
            
        }
    }];

}











@end
