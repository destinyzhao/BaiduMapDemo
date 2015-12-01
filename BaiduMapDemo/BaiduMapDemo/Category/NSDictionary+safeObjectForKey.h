//
//  NSDictionary+safeObjectForKey.h
//  PM4H
//
//  Created by iMacForiOSDev on 15/5/7.
//  Copyright (c) 2015年 重庆瑞加软件有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safeObjectForKey)

- (id)safeObjectForKey:(id)key;
- (id)safeStringForKey:(id)key;
- (id)safeArrayForKey:(id)key;
- (id)safeDictionaryForKey:(id)key;
- (float)safeFloatForKey:(id)key;
- (NSInteger)safeIntegerForKey:(id)key;
- (int)safeIntForKey:(id)key;
- (int)safeBOOLForKey:(id)key;

- (id)safeObjectForKeyPath:(NSString *)keyPath;
- (id)safeStringForKeyPath:(NSString *)keyPath;
- (id)safeArrayForKeyPath:(NSString *)keyPath;
- (id)safeDictionaryForKeyPath:(NSString *)keyPath;
- (float)safeFloatForKeyPath:(NSString *)keyPath;
- (NSInteger)safeIntegerForKeyPath:(NSString *)keyPath;
- (int)safeIntForKeyPath:(NSString *)keyPath;
- (BOOL)safeBOOLForKeyPath:(NSString *)keyPath;

@end
