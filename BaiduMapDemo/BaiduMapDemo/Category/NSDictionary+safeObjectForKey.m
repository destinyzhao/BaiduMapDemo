//
//  NSDictionary+safeObjectForKey.m
//  PM4H
//
//  Created by iMacForiOSDev on 15/5/7.
//  Copyright (c) 2015年 重庆瑞加软件有限公司. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"

@implementation NSDictionary (safeObjectForKey)


- (id)safeObjectForKey:(id)key
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return obj;
}

- (id)safeObjectForKeyPath:(NSString *)keyPath
{
    NSString *dicPath = [keyPath stringByReplacingOccurrencesOfString:keyPath.lastPathComponent withString:@""];
    dicPath = [dicPath stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    
    NSDictionary *aimDic = self;
    if (dicPath.length) {
        NSArray *pathComponentArr = [dicPath componentsSeparatedByString:@"/"];
        for (NSString *pathComp in pathComponentArr) {
            aimDic = [aimDic safeDictionaryForKey:pathComp];
        }
    }
    
    NSString *aimObj = [aimDic safeObjectForKey:keyPath.lastPathComponent];
    
    return aimObj;
}


- (id)safeStringForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj) {
        return @"";
    }
    return obj;
}

- (id)safeStringForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj) {
        return @"";
    }
    return obj;
}

- (id)safeArrayForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj) {
        return [NSMutableArray array];
    }
    return obj;
}

- (id)safeArrayForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj) {
        return [NSMutableArray array];
    }
    return obj;
}


- (id)safeDictionaryForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj) {
        return [NSMutableDictionary dictionary];
    }
    return obj;
}

- (id)safeDictionaryForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj) {
        return [NSMutableDictionary dictionary];
    }
    return obj;
}

- (float)safeFloatForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj || ![obj respondsToSelector:@selector(floatValue)]) {
        return 0.;
    }
    return [obj floatValue];
}

- (float)safeFloatForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj || ![obj respondsToSelector:@selector(floatValue)]) {
        return 0.;
    }
    return [obj floatValue];
}


- (NSInteger)safeIntegerForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj || ![obj respondsToSelector:@selector(integerValue)]) {
        return 0;
    }
    return [obj integerValue];
}


- (NSInteger)safeIntegerForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj || ![obj respondsToSelector:@selector(integerValue)]) {
        return 0;
    }
    return [obj integerValue];
}


- (int)safeIntForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj || ![obj respondsToSelector:@selector(intValue)]) {
        return 0;
    }
    return [obj intValue];
}

- (int)safeIntForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj || ![obj respondsToSelector:@selector(intValue)]) {
        return 0;
    }
    return [obj intValue];
}

- (int)safeBOOLForKey:(id)key
{
    id obj = [self safeObjectForKey:key];
    if (!obj || ![obj respondsToSelector:@selector(boolValue)]) {
        return NO;
    }
    return [obj boolValue];
}

- (BOOL)safeBOOLForKeyPath:(NSString *)keyPath
{
    id obj = [self safeObjectForKeyPath:keyPath];
    if (!obj || ![obj respondsToSelector:@selector(boolValue)]) {
        return NO;
    }
    return [obj boolValue];
}

@end
