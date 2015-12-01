//
//  CurrentLocationBubble.m
//  BaiduMapDemo
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "CurrentLocationBubble.h"

@implementation CurrentLocationBubble

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettings];
    }
    return self;
}

/**
 *@description  初始化设置
 *@param        无
 *@return       (void)
 */
- (void)initSettings
{
    CGRect frame = CGRectMake(0, 0, 208, 79);
    //    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:frame];
    bgImageView.image = imageWithName(@"2_curLocationBg");
    [self addSubview:bgImageView];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, 65, 16)];
    titleLbl.text = @"当前位置：";
    titleLbl.font = [UIFont systemFontOfSize:13.];
    titleLbl.textColor = [UIColor getColorWithRed:138. andGreen:138. andBlue:138.];
    [self addSubview:titleLbl];
    
    UILabel *curLocLbl = [[UILabel alloc]initWithFrame:CGRectMake(8, 25, 194, 46)];
    curLocLbl.textColor = [UIColor getColorWithHexString:@"#FB6719"];
    curLocLbl.font = [UIFont systemFontOfSize:14.];
    curLocLbl.numberOfLines = 0;
    [self addSubview:curLocLbl];
    self.currentLocationLbl = curLocLbl;
}

+ (id)currentLocationBubble
{
    CGRect frame = CGRectMake(0, 0, 208, 79);
    CurrentLocationBubble *bbView = [[CurrentLocationBubble alloc]initWithFrame:frame];
    
    return bbView;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
