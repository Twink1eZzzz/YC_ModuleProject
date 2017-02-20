//
//  YCLocationViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCLocationViewController.h"
#import "YC_LocationManager.h"

@interface YCLocationViewController ()<YCLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *latAndlonLabel;

@end

@implementation YCLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationService];
}

/**
 *  定位服务
 */
- (void)locationService{
    YC_LocationManager *locationManager = [YC_LocationManager sharedYC_LocationManager];
    locationManager.delegate = self;
    [locationManager startLocate];
}

#pragma mark - <HCLocationManagerDelegate>
- (void)loationMangerSuccessLocationWithCity:(NSString *)city{
    YCLog(@"city = %@",city);
    _cityLabel.text = [NSString stringWithFormat:@"%@",city];
}
- (void)loationMangerSuccessLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    YCLog(@"latitude = %f , longitude = %f",latitude,longitude);
    _latAndlonLabel.text = [NSString stringWithFormat:@"latitude:%f----longitude:%f",latitude,longitude];
}
- (void)loationMangerFaildWithError:(NSError *)error{
    YCLog(@"%@",error);
}

@end
