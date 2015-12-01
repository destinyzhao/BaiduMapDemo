//
//  MyBMKPointAnnotation.h
//  BaiduMapDemo
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBMKPointAnnotation : BMKPointAnnotation

@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) NSMutableDictionary *annDic;

@end
