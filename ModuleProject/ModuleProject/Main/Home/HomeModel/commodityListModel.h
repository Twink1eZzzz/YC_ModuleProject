//
//  commodityListModel.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/10.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commodityListModel : NSObject

@property (nonatomic , copy) NSString              * shopId;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * playMoney;
@property (nonatomic , copy) NSString              * classify;
@property (nonatomic , copy) NSString              * commodityId;
@property (nonatomic , copy) NSString              * commodityName;
@property (nonatomic , copy) NSString              * originalPrice;
@property (nonatomic , copy) NSString              * payPrice;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * shopName;
@property (nonatomic , copy) NSString              * soldCount;

@end
