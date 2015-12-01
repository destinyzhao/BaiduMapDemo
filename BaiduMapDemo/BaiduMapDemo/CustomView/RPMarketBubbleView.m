//
//  RPMarketBubbleView.m
//  SuperAiSong
//
//  Created by 赵文双 on 15/6/24.
//  Copyright (c) 2015年 AiChiJia. All rights reserved.
//

#import "RPMarketBubbleView.h"

@interface RPMarketBubbleView()

@property (strong, nonatomic) IBOutlet UIImageView *openStateImageView;

@end

@implementation RPMarketBubbleView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

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

- (void)updateFrames
{
    CGRect frame;
    
    frame.origin.x = 8.;
    frame.origin.y = 2.;
    frame.size = _openStateImageView.intrinsicContentSize;
    _openStateImageView.frame = frame;
    
    frame.size = [_scoreView intrinsicContentSize];
    _scoreView.frame = frame;
    
    [_nameLbl sizeToFit];
    frame = _nameLbl.frame;
    frame.origin.x = CGRectGetMaxX(_openStateImageView.frame)+5.;
    frame.origin.y = 8.;
    CGFloat maxWidth = self.frame.size.width-frame.origin.x-2.-_scoreView.frame.size.width-5.;
    if (frame.size.width > maxWidth) {
        frame.size.width = maxWidth;
    }
    _nameLbl.frame = frame;
    
    CGPoint center = _nameLbl.center;
    _scoreView.center = CGPointMake(center.x+frame.size.width/2.+_scoreView.frame.size.width/2.+2., center.y);
    
    [_startSendLbl sizeToFit];
    frame = _startSendLbl.frame;
    frame.origin = CGPointMake(8, CGRectGetMaxY(_openStateImageView.frame));
    _startSendLbl.frame = frame;
    
    [_averArrivalTimeLbl sizeToFit];
    frame = _averArrivalTimeLbl.frame;
    frame.origin.x = CGRectGetMaxX(_startSendLbl.frame)+10.;
    frame.origin.y = _startSendLbl.frame.origin.y;
    _averArrivalTimeLbl.frame = frame;
}

/**
 *@description  初始化设置
 *@param        无
 *@return       (void)
 */
- (void)initSettings
{
    CGRect frame;
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:imageWithName(@"2_marketBubbleBg")];
    bgImageView.frame = self.bounds;
    [self addSubview:bgImageView];
    
    self.openStateImageView = [[UIImageView alloc]initWithImage:imageWithName(@"2_opening_small")];
    _openStateImageView.highlightedImage = imageWithName(@"2_closing_small");
    _openStateImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_openStateImageView];
    
    self.nameLbl = [[UILabel alloc]init];
    _nameLbl.font = [UIFont systemFontOfSize:15.];
    [self addSubview:_nameLbl];
    
    self.scoreView = [[RPUserLevelView alloc]initWithImage:imageWithName(@"rose_5")];
    [self addSubview:_scoreView];
    
    self.startSendLbl = [[UILabel alloc]init];
    _startSendLbl.font = [UIFont systemFontOfSize:13.];
    _startSendLbl.textColor = [UIColor blackColor];
    [self addSubview:_startSendLbl];
    
    self.averArrivalTimeLbl = [[UILabel alloc]init];
    _averArrivalTimeLbl.textColor = [UIColor getColorWithHexString:@"#818181"];
    _averArrivalTimeLbl.font = [UIFont systemFontOfSize:13.];
    [self addSubview:_averArrivalTimeLbl];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:imageWithName(@"2_rightArrow")];
    [arrowImageView sizeToFit];
    frame = arrowImageView.frame;
    frame.origin = CGPointMake(self.frame.size.width-8.-arrowImageView.frame.size.width,  32.);
    arrowImageView.frame = frame;
    [self addSubview:arrowImageView];
    
    self.workingTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake(8, 51, self.frame.size.width-8.-8., 16.)];
    _workingTimeLbl.font = [UIFont systemFontOfSize:13.];
    _workingTimeLbl.textColor = _averArrivalTimeLbl.textColor;
    [self addSubview:_workingTimeLbl];
    
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)setIsOpening:(BOOL)isOpening
{
    _isOpening = isOpening;
    _openStateImageView.highlighted = !_isOpening;
    if (_isOpening) {
        _nameLbl.textColor = [UIColor getColorWithHexString:@"#FB5B00"];
    }else{
        _nameLbl.textColor = [UIColor blackColor];
    }
}



@end
