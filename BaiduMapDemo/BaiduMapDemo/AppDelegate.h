//
//  AppDelegate.h
//  BaiduMapDemo
//
//  Created by Alex on 15/11/30.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) BMKMapManager* mapManager;

@end

