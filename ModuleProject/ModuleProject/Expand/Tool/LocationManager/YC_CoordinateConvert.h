//
//  YC_CoordinateConvert.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YC_CoordinateConvert : NSObject

/**
 *  地球坐标转换为火星坐标
 *
 *  @param location 地球坐标
 *
 *  @return 返回转换后的火星坐标
 */
+ (CLLocation *)transformToMars:(CLLocation *)location;

@end
