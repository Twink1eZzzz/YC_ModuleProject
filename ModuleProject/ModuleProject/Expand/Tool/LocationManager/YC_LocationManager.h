//
//  YC_LocationManager.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "YCSingleton.h"

@protocol YCLocationManagerDelegate <NSObject>

@optional

- (void)loationMangerSuccessLocationWithCity:(NSString *)city;
- (void)loationMangerSuccessLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
- (void)loationMangerFaildWithError:(NSError *)error;

@end

@interface YC_LocationManager : NSObject

YCSingletonH(YC_LocationManager)

@property (weak, nonatomic) id<YCLocationManagerDelegate>delegate;

- (void)startLocate;

@end
