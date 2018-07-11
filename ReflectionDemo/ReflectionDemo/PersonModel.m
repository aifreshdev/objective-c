//
//  NSObject+PersonModel.m
//  ReflectionDemo
//
//  Created by Vincent li on 11/1/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import "PersonModel.h"
#import <objc/runtime.h>

@implementation PersonModel : NSObject

- (instancetype)initWithNSDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self prepareModel:dict];
    }
    return self;
}

- (void)prepareModel:(NSDictionary *)dict {
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyCString = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propertyCString encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    
    for (NSString *key in keys) {
        if ([dict valueForKey:key]) {
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
}
@end
