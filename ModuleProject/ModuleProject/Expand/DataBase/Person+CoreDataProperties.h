//
//  Person+CoreDataProperties.h
//  
//
//  Created by 李奕辰 on 2017/2/17.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t sex;
@property (nonatomic) int32_t tall;

@end

NS_ASSUME_NONNULL_END
