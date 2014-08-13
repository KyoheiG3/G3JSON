//
//  G3JSONPropertyInfo.h
//  G3JSON
//
//  Created by Kyohei Ito on 2014/08/06.
//  Copyright (c) 2014年 kyohei_ito. All rights reserved.
//

@interface G3JSONPropertyInfo : NSObject

@property (nonatomic, copy) NSString *propertyName;
@property (nonatomic, copy) NSString *attributeName;
@property (nonatomic, assign) Class attributeClass;

+ (instancetype)infoWithPropertyName:(NSString *)name toClass:(Class)clazz;

@end
