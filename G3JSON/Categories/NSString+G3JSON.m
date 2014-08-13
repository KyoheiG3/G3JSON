//
//  NSString+G3JSON.m
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import "NSString+G3JSON.h"

@implementation NSString (G3JSON)

- (NSString *)camelcaseStringBySeparator:(NSString *)separator {
    if (self.length <= 0) {
        return self;
    }

    NSArray *separatedList = [self componentsSeparatedByString:separator];
    NSMutableString *parsedString = [separatedList[0] lowercaseString].mutableCopy;

    for (NSInteger index = 1; index < separatedList.count; index++) {
        NSString *separatedString = separatedList[index];

        [parsedString appendString:[[separatedString substringWithRange:NSMakeRange(0, 1)] uppercaseString]];
        [parsedString appendString:[[separatedString substringFromIndex:1] lowercaseString]];
    }

    return parsedString.copy;
}

- (NSString *)snakecaseTocamelcase {
    return [self camelcaseStringBySeparator:@"_"];
}

@end
