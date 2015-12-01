//
//  RPUserLevelView.m
//  SuperAiSong
//
//  Created by iMacForiOSDev on 15/7/14.
//  Copyright © 2015年 AiChiJia. All rights reserved.
//

#import "RPUserLevelView.h"

#import "NSDictionary+safeObjectForKey.h"

@implementation RPUserLevelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//卖家等级		买家等级
//4分-10分        玫瑰1	4分-10分	玫瑰1
//11分-40分           2	11分-40分	2
//41分-90分           3	41分-90分	3
//91分-150分          4	91分-150分	4
//151分-250分         5	151分-250分	5
//251分-500分     宝石1	251分-500分	宝石1
//501分-1000分        2	501分-1000分	2
//1001分-2000分       3	1001分-2000分	3
//200分1-5000分       4	200分1-5000分	4
//5001分-10000分      5	5001分-10000分	5
//10001分-20000分	王冠1	10001分-20000分	王冠1
//20001分-50000分         2	20001分-50000分	2
//50001分-100000分	3	50001分-100000分	3
//100001分-200000分	4	100001分-200000分	4
//200001分-500000分	5	200001分-500000分	5
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
    self.backgroundColor = [UIColor clearColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setScore:(CGFloat)score
{
    _score = score;
    _selectedCount = score;
    NSArray *arr = @[
                     @{@"from":@(4),@"to":@(10),@"image":@"rose_1"},
                     @{@"from":@(11),@"to":@(40),@"image":@"rose_2"},
                     @{@"from":@(41),@"to":@(90),@"image":@"rose_3"},
                     @{@"from":@(91),@"to":@(150),@"image":@"rose_4"},
                     @{@"from":@(151),@"to":@(250),@"image":@"rose_5"},
                     @{@"from":@(251),@"to":@(500),@"image":@"diamond_1"},
                     @{@"from":@(501),@"to":@(1000),@"image":@"diamond_2"},
                     @{@"from":@(1001),@"to":@(2000),@"image":@"diamond_3"},
                     @{@"from":@(2001),@"to":@(5000),@"image":@"diamond_4"},
                     @{@"from":@(5001),@"to":@(10000),@"image":@"diamond_5"},
                     @{@"from":@(10001),@"to":@(20000),@"image":@"huangguan_1"},
                     @{@"from":@(20001),@"to":@(50000),@"image":@"huangguan_2"},
                     @{@"from":@(50001),@"to":@(100000),@"image":@"huangguan_3"},
                     @{@"from":@(100001),@"to":@(200000),@"image":@"huangguan_4"},
                     @{@"from":@(200001),@"to":@(500000),@"image":@"huangguan_5"}
                     ];
    self.image = nil;
    for (NSDictionary *dic in arr) {
        NSInteger from = [dic safeIntegerForKey:@"from"];
        NSInteger to = [dic safeIntegerForKey:@"to"];
        if (_score >= from && _score <= to) {
            NSString *imageName = [dic safeStringForKey:@"image"];
            self.image = [UIImage imageNamed:imageName];
            break;
        }
    }
    
}


- (void)setSelectedCount:(CGFloat)selectedCount
{
    self.score = selectedCount;
}

@end
