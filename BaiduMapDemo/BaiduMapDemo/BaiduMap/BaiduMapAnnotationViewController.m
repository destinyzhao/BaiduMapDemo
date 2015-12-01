//
//  BaiduMapAnnotationViewController.m
//  BaiduMapDemo
//
//  Created by Alex on 15/12/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "BaiduMapAnnotationViewController.h"
#import "CurrentLocationBubble.h"
#import "MapHelper.h"
#import "MyBMKPointAnnotation.h"

@interface BaiduMapAnnotationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService* _locService;
    BMKGeoCodeSearch *_geocodesearch;
    
    CLLocationCoordinate2D currentLocation; // 当前定位经纬度
    
    BMKPointAnnotation *currentLocationAnnotation; // 当前定位地址的Annotation
    
    CurrentLocationBubble *currentLocationBubble;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@end

@implementation BaiduMapAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locService.distanceFilter = 100.f;
    _locService.delegate = self;
    [_locService startUserLocationService];
    
     _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    
    currentLocationBubble = [CurrentLocationBubble currentLocationBubble];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 自定义方法
- (void)reverseGeoCodeWithCoordinate2D:(CLLocationCoordinate2D)coord
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coord;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

- (void)updateAnnotations
{
    
    NSMutableArray *anns = [self getAnnotations];
    
    currentLocationBubble.currentLocationLbl.text = currentLocationAnnotation.title;
    if (currentLocationAnnotation) {
        [anns addObject:currentLocationAnnotation];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:anns];
    
    
//    CGFloat distance = 1000;
//    BMKCoordinateRegion region = BMKCoordinateRegionMakeWithDistance(currentShowLocation, distance, distance);
//    region = [_mapView regionThatFits:region];
//    [_mapView setRegion:region animated:YES];
}

- (NSMutableArray *)getAnnotations
{
    
    MyBMKPointAnnotation *ann = [[MyBMKPointAnnotation alloc]init];
    CLLocationCoordinate2D corr = CLLocationCoordinate2DMake(29.533535000000001, 106.48508099999999);
    ann.coordinate = corr;
    ann.title = @" ";
    ann.tag = 1;
    
    MyBMKPointAnnotation *ann1 = [[MyBMKPointAnnotation alloc]init];
    CLLocationCoordinate2D corr1 = CLLocationCoordinate2DMake(29.532553, 106.48514400000001);
    ann1.coordinate = corr1;
    ann1.title = @" ";
    ann1.tag = 2;
    
    MyBMKPointAnnotation *ann2 = [[MyBMKPointAnnotation alloc]init];
    CLLocationCoordinate2D corr2 = CLLocationCoordinate2DMake(29.533697400000001, 106.4851228);
    ann2.coordinate = corr2;
    ann2.title = @" ";
    ann2.tag = 3;
    
    NSMutableArray *annotationsArray = [NSMutableArray arrayWithObjects:ann,ann1,ann2, nil];
    
    return annotationsArray;
}

#pragma mark -
#pragma mark - BMKLocationServiceDelegate
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    
    [self reverseGeoCodeWithCoordinate2D:userLocation.location.coordinate];
    currentLocation = userLocation.location.coordinate;
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


#pragma mark -
#pragma mark - BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    currentLocationAnnotation = [[BMKPointAnnotation alloc]init];
    currentLocationAnnotation.coordinate = currentLocation;
    currentLocationAnnotation.title = result.address;
    currentLocationBubble.currentLocationLbl.text = result.address;
    
    BMKMapStatus *status = [[BMKMapStatus alloc]init];
    status.fLevel = 18;
    status.targetScreenPt = CGPointZero;
    status.targetGeoPt = currentLocation;
    [_mapView setMapStatus:status withAnimation:YES];
    
    [self updateAnnotations];
    
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if (annotation == currentLocationAnnotation) {
        //当前位置
        return [MapHelper mapView:_mapView viewForAnnotation:annotation customPaoPaoView:currentLocationBubble];
    }else{
        //商家
        return [MapHelper mapView:_mapView viewForAnnotation:annotation];
    }
}

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    NSLog(@"paopaoclick");
 
    MyBMKPointAnnotation *ann = view.annotation;
    NSLog(@"%ld",ann.tag);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
