//
//  CurrentLocationBubble.h
//  BaiduMapDemo
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentLocationBubble : UIView

@property (nonatomic,strong)UILabel *currentLocationLbl;

+ (instancetype)currentLocationBubble;

@end
