//
//  NSString+G3JSON.h
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (G3JSON)

- (NSString *)camelcaseStringBySeparator:(NSString *)separator;
- (NSString *)snakecaseTocamelcase;

@end
