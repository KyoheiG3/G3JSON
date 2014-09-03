//
//  G3JSONFromJson.m
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import "G3JSONFromJson.h"
#import "G3JSONPropertyInfo.h"

@implementation G3JSONFromJson

- (id)objectWithJSONObject:(NSDictionary *)object toClass:(Class)clazz {
    NSObject *generateObject = [[clazz alloc] init];

    for (NSString *dicKey in object.allKeys) {
        G3JSONPropertyInfo *info = [G3JSONPropertyInfo infoWithPropertyName:dicKey toClass:clazz];
        if (info == nil) {
            continue;
        }

        id value = object[dicKey];

        // TODO: generate class object into array.
        if ([info.attributeClass isSubclassOfClass:NSArray.class]) {
            NSMutableArray *values = [NSMutableArray array];

            for (id val in value) {
                [values addObject:val];
            }

            value = values.copy;
        }

        if ([value isKindOfClass:NSDictionary.class] == YES &&
            [info.attributeClass isSubclassOfClass:NSDictionary.class] == NO) {
            value = [self objectWithJSONObject:value toClass:info.attributeClass];
        }

        if ([generateObject validateValue:&value forKey:info.attributeName error:nil]) {
            if ([info.attributeClass isSubclassOfClass:NSString.class] && [value isKindOfClass:NSNull.class]) {
                value = nil;
            }

            [generateObject setValue:value forKey:info.attributeName];
        }
    }

    return generateObject;
}

@end
