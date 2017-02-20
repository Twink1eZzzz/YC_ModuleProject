//
//  YC_LocationManager.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YC_LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "YC_CoordinateConvert.h"
#import "LBXAlertAction.h"

@interface YC_LocationManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation YC_LocationManager

YCSingletonM(YC_LocationManager)

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

- (void)startLocate{
    if([CLLocationManager locationServicesEnabled]) {
        
        [self.locationManager startUpdatingLocation];
    }
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations lastObject];
    //国内经纬度转换为火星坐标
    currentLocation = [YC_CoordinateConvert transformToMars:currentLocation];
    [_locationManager stopUpdatingLocation];
    //获取经纬度
    CLLocationDegrees aLatitude = currentLocation.coordinate.latitude;
    CLLocationDegrees aLongitude = currentLocation.coordinate.longitude;
    if ([_delegate respondsToSelector:@selector(loationMangerSuccessLocationWithLatitude: longitude:)]) {
        [_delegate loationMangerSuccessLocationWithLatitude:aLatitude longitude:aLongitude];
    }
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            if ([city containsString:@"市辖区"] || [city containsString:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市辖区" withString:@""];
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            
            if ([_delegate respondsToSelector:@selector(loationMangerSuccessLocationWithCity:)]) {
                [_delegate loationMangerSuccessLocationWithCity:city];
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            if([CLLocationManager locationServicesEnabled])
            {
                [LBXAlertAction showAlertWithTitle:@"提示" msg:@"定位服务授权被拒绝，是否前往设置开启？" buttonsStatement:@[@"好的",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
                    if (buttonIdx == 0) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL: url];
                        }
                    }
                }];
            }
            else
            {
                
            }
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([_delegate respondsToSelector:@selector(loationMangerFaildWithError:)]) {
        [_delegate loationMangerFaildWithError:error];
    }
}



@end
