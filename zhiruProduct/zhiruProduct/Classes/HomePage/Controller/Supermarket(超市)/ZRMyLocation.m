//
//  ZRMyLocation.m
//  zhiruProduct
//
//  Created by nanding on 16/9/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyLocation.h"
#import <CoreLocation/CoreLocation.h>




@interface ZRMyLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) GMSGeocoder *myGeocoder;

@end

@implementation ZRMyLocation


+(instancetype)shareInstance
{
    static ZRMyLocation *location;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        location = [[ZRMyLocation alloc] init];
    });
    return location;
    
}


-(GMSGeocoder *)myGeocoder
{
    if (!_myGeocoder) {
        _myGeocoder = [[GMSGeocoder alloc] init];
    }
    return _myGeocoder;
}


-(void)getMylocation
{
    // Setup location services
//    if (![CLLocationManager locationServicesEnabled]) {
//        //NSLog(@"Please enable location services");
//        return;
//    }
//    
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//        //NSLog(@"Please authorize location services");
//        return;
//    }
    
    _manager = [[CLLocationManager alloc] init];
    if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_manager requestWhenInUseAuthorization];
    }
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.distanceFilter = 5.0f;
    [_manager startUpdatingLocation];
    
    
    //[self geocode];
    
}


#pragma mark - GM



//开放接口，获取经纬度
+ (void)geoSearchWithString:(NSString *)string Callback:(CallBack)callback{
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
            CLLocationCoordinate2D search;
            NSDictionary *addressDic = returenArray[0];
            NSDictionary *locationDic = addressDic[@"geometry"][@"location"];
            search.longitude = [locationDic[@"lng"] floatValue];
            search.latitude = [locationDic[@"lat"] floatValue];
            //[_googleMapView animateToLocation:search];
            if (callback) {
                callback(search);
            }
            
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    //return search;
    
}





#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //NSLog(@"Please authorize location services");
        return;
    }
    
    //NSLog(@"CLLocationManager error: %@", error.localizedFailureReason);
    return;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    
    //NSLog(@"newLocation lat:%f", location.coordinate.latitude);
    //NSLog(@"newLocation lng:%f", location.coordinate.longitude);
    
    CLLocationCoordinate2D coodi = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    [CustomHudView show];
    [self.myGeocoder reverseGeocodeCoordinate:coodi completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        
        GMSAddress *address = response.firstResult;
        if (address) {
            //NSLog(@"Geocoder result: %@", address);
            self.myLocationStr = address.thoroughfare;
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocation_Noti object:self.myLocationStr];
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kCoodinate_Noti object:nil userInfo:@{@"longitude":[NSString stringWithFormat:@"%f",address.coordinate.longitude],@"latitude":[NSString stringWithFormat:@"%f",address.coordinate.latitude]}];
            [CustomHudView dismiss];
        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kCoodinate_Noti object:nil userInfo:@{@"longitude":[NSString stringWithFormat:@"0"],@"latitude":[NSString stringWithFormat:@"0"]}];
            
            [CustomHudView dismiss];
        }

        
        
        
    }];
    [self.manager stopUpdatingLocation];
    
    
}




// 代理方法中监听授权的改变,被拒绝有两种情况,一是真正被拒绝,二是服务关闭了
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户未决定");
            break;
        }
            // 系统预留字段,暂时还没用到
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"受限制");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 被拒绝有两种情况 1.设备不支持定位服务 2.定位服务被关闭
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"真正被拒绝");
                
                
                [ZRAlertControl alertToolWithLocationWithWindow:[UIApplication sharedApplication].keyWindow.rootViewController andActionTitle:@"定位服务未开启" andText:@"请进去系统‘设置’》‘隐私’》‘定位服务’中打开开关,并允许嘿唐使用定位服务" andButtonOneCallBack:^{
                    
                    // 跳转到设置界面
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        
                        [[UIApplication sharedApplication] openURL:url];
                    }
                    
                }];
                
                
                
               
            }
            else {
                NSLog(@"没有开启此功能");
                

            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"前台定位授权");
            break;
        }
            
        default:
            break;
    }
}






///**
// *  地理编码：地名—>经纬度坐标
// */
//- (void)geocode {
//    //1.获得输入的地址
//    //NSString *address=@"中国辽宁省沈阳市沈河区顺通青年公园旁滨湖丽园内" ;
//    NSString *address=@"加拿大国" ;
//    if (address.length==0) return;
//    
//    //2.开始地理编码
//    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
//    [self.myGeocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
//        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
//        if (error || placemarks.count==0) {
//            NSLog(@"你输入的地址没找到，可能在月球上");
//        }else   //  编码成功，找到了具体的位置信息
//        {
//            //打印查看找到的所有的位置信息
//            /*
//             name:名称
//             locality:城市
//             country:国家
//             postalCode:邮政编码
//             */
//            for (CLPlacemark *placemark in placemarks) {
//                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
//            }
//            
//            //取出获取的地理信息数组中的第一个显示在界面上
//            CLPlacemark *firstPlacemark=[placemarks firstObject];
//            //详细地址名称
//            NSLog(@"firstPlacemark.name:%@",firstPlacemark.name);
//            //self.detailAddressLabel.text=firstPlacemark.name;
//            //纬度
//            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
//            //经度
//            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
//            //            self.latitudeLabel.text=[NSString stringWithFormat:@"%.2f",latitude];
//            //            self.longitudeLabel.text=[NSString stringWithFormat:@"%.2f",longitude];
//            
//            NSLog(@"Location lat:%f", latitude);
//            NSLog(@"Location lng:%f", longitude);
//            
//        }
//    }];
//}
///**
// *  反地理编码：经纬度坐标—>地名
// */
//- (NSString *)reverseGeocodeWithLogitude:(NSString *)logitude WithLatitude:(NSString *)latitude {
//    __block NSString *addressStr;
//    //1.获得输入的经纬度
//    //NSString *longtitudeText=self.longitudeField.text;
//    //NSString *latitudeText=self.latitudeField.text;
//    if (logitude.length==0||latitude.length==0){
//        return nil;
//    }
//
//    CLLocationDegrees lati=[latitude doubleValue];
//    CLLocationDegrees longitude=[logitude doubleValue];
//
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:lati longitude:longitude];
//    //2.反地理编码
//    [self.myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        if (error||placemarks.count==0) {
//            //self.reverdeDetailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
//            NSLog(@"你输入的地址没找到，可能在月球上");
//        }
//        else//编码成功
//        {
//            //显示最前面的地标信息
//            CLPlacemark *firstPlacemark=[placemarks firstObject];
//            //self.reverdeDetailAddressLabel.text=firstPlacemark.name;
//            addressStr = firstPlacemark.name;
//            //            //经纬度
//            //            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
//            //            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
//            //            self.latitudeField.text=[NSString stringWithFormat:@"%.2f",latitude];
//            //            self.longitudeField.text=[NSString stringWithFormat:@"%.2f",longitude];
//        }
//
//        
//    }];
//    
//    return addressStr;
//    
//    
//}




- (NSString *)reverseGeocodeWithLogitude:(NSString *)logitude WithLatitude:(NSString *)latitude
{
    __block NSString *addressStr;
    CLLocationDegrees lati=[latitude doubleValue];
    CLLocationDegrees longitude=[logitude doubleValue];
    CLLocationCoordinate2D coodi = CLLocationCoordinate2DMake(lati, longitude);
    [self.myGeocoder reverseGeocodeCoordinate:coodi completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        
        GMSAddress *address = response.firstResult;
        if (address) {
            //NSLog(@"Geocoder result: %@", address);
            addressStr = address.country;
        } else {
            //            NSLog(@"Could not reverse geocode point (%f,%f): %@",
            //                  coordinate.latitude, coordinate.longitude, error);
        }
        
        
        
        
    }];
    
    return addressStr;

}


@end
