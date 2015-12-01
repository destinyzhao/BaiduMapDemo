//
//  RPMarketBubbleView.h
//  SuperAiSong
//
//  Created by 赵文双 on 15/6/24.
//  Copyright (c) 2015年 AiChiJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPUserLevelView.h"

@interface RPMarketBubbleView : UIView

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *startSendLbl;
@property (strong, nonatomic) IBOutlet UILabel *averArrivalTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *workingTimeLbl;
@property (strong, nonatomic) IBOutlet RPUserLevelView *scoreView;

//是否正在营业
@property (nonatomic,assign)BOOL isOpening;

- (void)updateFrames;

@end
