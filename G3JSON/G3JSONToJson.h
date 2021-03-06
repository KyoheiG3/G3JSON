//
//  G3JSONToJson.h
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G3JSONToJson : NSObject

- (NSObject *)objectToValue:(id)object;
- (NSMutableDictionary *)JSONWithAnyObject:(id)object;

@end
