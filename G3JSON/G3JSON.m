//
//  G3JSON.m
//  G3JSON
//
//  Created by Kyohei Ito on 2014/07/31.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import "G3JSON.h"
#import "G3JSONFromJson.h"
#import "G3JSONToJson.h"

@implementation G3JSON

+ (NSString *)toJSON:(id)object {
    NSDictionary *attrs = [[self class] toJSONObject:object];

    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:attrs options:0 error:&error];

    if (error || !data) {
        return nil;
    }

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)toJSONObject:(id)object {
    G3JSONToJson *g3json = [[G3JSONToJson alloc] init];

    return [g3json JSONWithAnyObject:object];
}

+ (id)fromJSON:(NSString *)jsonString toClass:(Class)clazz {
    NSString *encodedJsonString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                                        (CFStringRef)jsonString,
                                                                                                                        CFSTR(""),
                                                                                                                        kCFStringEncodingUTF8));
    NSData *jsonData = [encodedJsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;
    id json = nil;
    if ([jsonData isKindOfClass:[NSData class]]) {
        json = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];
    }

    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }

    return [[self class] fromJSONObject:json toClass:clazz];
}

+ (id)fromJSONObject:(id)jsonObject toClass:(Class)clazz {
    G3JSONFromJson *g3json = [[G3JSONFromJson alloc] init];

    if ([jsonObject isKindOfClass:NSDictionary.class]) {
        return [g3json objectWithJSONObject:jsonObject toClass:clazz];
    } else if ([jsonObject isKindOfClass:NSArray.class]) {
        NSMutableArray *objects = [NSMutableArray array];

        for (id object in jsonObject) {
            [objects addObject:[jsonObject objectWithJSONObject:object toClass:clazz]];
        }

        return objects.copy;
    }

    return nil;
}

@end
