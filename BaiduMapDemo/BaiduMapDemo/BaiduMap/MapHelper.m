//
//  MapHelper.m
//  BaiduMapDemo
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "MapHelper.h"
#import "RPMarketBubbleView.h"

@implementation MapHelper

// 根据anntation生成对应的View
+ (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"AnnotationViewIDForMarket";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        annotationView.canShowCallout = YES;
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorRed;
        // 从天上掉下效果
        annotationView.animatesDrop = NO;
        // 设置可拖拽
        //        annotationView.draggable = self.canEditLocation;
    }
    
    annotationView.image = imageWithName(@"2_market_open_ann");

    RPMarketBubbleView *bbView = [[RPMarketBubbleView alloc]initWithFrame:CGRectMake(0, 0, 229, 79)];
//    bbView.isOpening = opening;
    bbView.nameLbl.text = @"测试";
    bbView.scoreView.selectedCount = 200.f;
    bbView.startSendLbl.text = [NSString stringWithFormat:@"%@元起配送",@"10"];
    bbView.averArrivalTimeLbl.text = [NSString stringWithFormat:@"平均送达：%@分钟",@"30"];
    bbView.workingTimeLbl.text = [NSString stringWithFormat:@"营业时间：%@-%@",@"8:00",@"21:00"];
    [bbView updateFrames];
    
    annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:bbView];
    
    return annotationView;
}

// 根据anntation生成当前的annotation
+ (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation customPaoPaoView:(UIView *)customPaoPaoView
{
    
    NSString *AnnotationViewID = @"AnnotationViewIDForCurLoc";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        //        annotationView.pinColor = BMKPinAnnotationColorRed;
        // 从天上掉下效果
        annotationView.animatesDrop = NO;
        // 设置可拖拽
        //        annotationView.draggable = self.canEditLocation;
    }
    
    annotationView.image = imageWithName(@"2_location");
    customPaoPaoView.userInteractionEnabled = NO;
    annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:customPaoPaoView];
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

@end
