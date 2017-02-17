//
//  Person+CoreDataProperties.m
//  
//
//  Created by 李奕辰 on 2017/2/17.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;
@dynamic sex;
@dynamic tall;

@end
