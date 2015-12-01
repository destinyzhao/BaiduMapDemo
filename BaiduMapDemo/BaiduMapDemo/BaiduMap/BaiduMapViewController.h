//
//  BaiduMapViewController.h
//  BaiduMapDemo
//
//  Created by Alex on 15/11/30.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseAddressDelegate;

@interface BaiduMapViewController : UIViewController

@property (nonatomic,assign)CLLocationCoordinate2D location;
@property (nonatomic,assign)id<ChooseAddressDelegate> delegate;

@end


@protocol ChooseAddressDelegate <NSObject>

@optional
- (void)chooseAddressController:(BaiduMapViewController *)aVC didGetLocation:(CLLocationCoordinate2D)aLocation andAddress:(NSString *)anAddress;

@end