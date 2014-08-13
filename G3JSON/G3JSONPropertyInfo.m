//
//  G3JSONPropertyInfo.m
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import <objc/runtime.h>
#import "G3JSONPropertyInfo.h"
#import "NSString+G3JSON.h"

@implementation G3JSONPropertyInfo

+ (instancetype)infoWithPropertyName:(NSString *)name toClass:(Class)clazz {
    return [[self alloc] initWithPropertyName:name toClass:clazz];
}

- (id)initWithPropertyName:(NSString *)name toClass:(Class)clazz {
    self = [super init];
    if (self) {
        NSString *attributes = [self classPropertyAttributesForName:name toClass:clazz];

        if (!attributes) {
            name = [name snakecaseTocamelcase];
            attributes = [self classPropertyAttributesForName:name toClass:clazz];
        }

        if (attributes == nil) {
            return nil;
        }

        NSArray *separatedList = [attributes componentsSeparatedByString:@","];
        self.attributeClass = [self classWithType:separatedList[0]];
        self.attributeName = [separatedList.lastObject substringFromIndex:1];

        if (self.attributeName.length == 0) {
            self.attributeName = name;
        }

        self.propertyName = name;
    }
    return self;
}

- (NSString *)classPropertyAttributesForName:(NSString *)name toClass:(Class)clazz {
    objc_property_t property = class_getProperty(clazz, name.UTF8String);

    if (property) {
        return [NSString stringWithUTF8String:property_getAttributes(property)];
    }

    return nil;
}

- (Class)classWithType:(NSString *)attribute {
    NSString *classString = nil;

    if ([[attribute substringToIndex:1] isEqualToString:@"T"] == YES &&
        [[attribute substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"@"] == NO) {
        classString = [attribute substringWithRange:NSMakeRange(1, 1)];
    } else if (attribute.length == 2) {
        classString = @"id";
    } else {
        classString = [attribute substringWithRange:NSMakeRange(3, attribute.length - 4)];
    }

    return NSClassFromString(classString);
}

@end
