//
//  NSObject+PersonModel.h
//  ReflectionDemo
//
//  Created by Vincent li on 11/1/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *job;

- (instancetype)initWithNSDictionary:(NSDictionary *)dict;
- (void)prepareModel:(NSDictionary *)dict;
@end
