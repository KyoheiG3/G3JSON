//
//  G3JSONToJson.m
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import <objc/runtime.h>
#import "G3JSONToJson.h"

@implementation G3JSONToJson

- (NSObject *)objectToValue:(id)object {
    if ([object isKindOfClass:NSNumber.class] || [object isKindOfClass:NSString.class]) {
        return object;
    } else if ([object isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];

        for (NSString *key in[object allKeys]) {
            dic[key] = [self objectToValue:object[key]];
        }

        return dic;
    } else if ([object isKindOfClass:NSArray.class]) {
        NSMutableArray *array = [NSMutableArray array];

        for (id obj in object) {
            [array addObject:[self objectToValue:obj]];
        }

        return array;
    } else if ([object isKindOfClass:NSObject.class]) {
        return [self JSONWithAnyObject:object];
    } else {
        return [NSNull null];
    }
}

- (NSMutableDictionary *)JSONWithAnyObject:(id)object {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);

    for (NSInteger index = 0; index < count; index++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(propertyList[index])];

        id value = [object valueForKey:propertyName];

        if (value) {
            [dict setValue:[self objectToValue:value] forKey:propertyName];
        } else {
            [dict setValue:NSNull.null forKey:propertyName];
        }
    }

    free(propertyList);

    return dict;
}

@end
