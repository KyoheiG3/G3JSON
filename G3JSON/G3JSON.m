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
    G3JSONToJson *g3json = [[G3JSONToJson alloc] init];

    NSDictionary *attrs = [g3json JSONWithAnyObject:object];

    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:attrs options:0 error:&error];

    if (error || !data) {
        return nil;
    }

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
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

    G3JSONFromJson *g3json = [[G3JSONFromJson alloc] init];

    if ([json isKindOfClass:NSDictionary.class]) {
        return [g3json objectWithJSONObject:json toClass:clazz];
    } else if ([json isKindOfClass:NSArray.class]) {
        NSMutableArray *objects = [NSMutableArray array];

        for (id object in json) {
            [objects addObject:[json objectWithJSONObject:object toClass:clazz]];
        }

        return objects.copy;
    }

    return nil;
}

@end
