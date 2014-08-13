//
//  G3JSON.h
//  G3JSON
//
//  Created by Kyohei Ito on 2014/07/31.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

@interface G3JSON : NSObject

+ (NSString *)toJSON:(id)object;
+ (id)fromJSON:(NSString *)jsonString toClass:(Class)clazz;

@end
