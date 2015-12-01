//
//  BaiduMapViewController.m
//  BaiduMapDemo
//
//  Created by Alex on 15/11/30.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "BaiduMapViewController.h"

@interface BaiduMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate,BMKPoiSearchDelegate>
{
    BMKLocationService* _locService;
    BMKGeoCodeSearch *_geocodesearch;
    BMKPoiSearch *_poiSearch;
    NSString *cityName;
    CLLocationCoordinate2D currentUserLocation;///当前定位位置
    NSMutableArray *poiSearchResultArr;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchTf;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *poiTableViewHCstt;
@property (nonatomic,assign)BOOL canChooseAddress;

@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addressView.hidden = YES;
    
    poiSearchResultArr = [NSMutableArray array];
    _poiTableViewHCstt.constant = 0.;
    
    _locService = [[BMKLocationService alloc]init];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    _searchView.layer.shadowColor = [UIColor getColorWithRed:200. andGreen:200. andBlue:200.].CGColor;
    _searchView.layer.shadowOpacity = 1.;
    _searchView.layer.shadowOffset = CGSizeMake(1., 1.);
    
    _locationView.layer.shadowColor = [UIColor getColorWithRed:200. andGreen:200. andBlue:200.].CGColor;
    _locationView.layer.shadowOpacity = 1.;
    _locationView.layer.shadowOffset = CGSizeMake(1., 1.);
    
    [_searchTf addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _addressLbl.text = @"";

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
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    if (_location.latitude != 0 && _location.longitude != 0) {
        [self reverseGeoCodeWithCoordinate2D:_location];
        [self gotoGeoPoint:_location];
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
    }else{
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    }
    //    _mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 自定义方法
// 反geo检索信息
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

// 更新地图状态
- (void)gotoGeoPoint:(CLLocationCoordinate2D)geoPoint
{
    if (geoPoint.latitude==0. && geoPoint.longitude==0.) {
        return;
    }
    CGPoint locPoint = CGPointMake(CGRectGetMidX(_addressView.bounds), CGRectGetMaxY(_addressView.bounds));
    locPoint = [_addressView convertPoint:locPoint toView:_mapView];
    BMKMapStatus *status = [[BMKMapStatus alloc]init];
    status.fLevel = 18.;
    status.targetGeoPt = geoPoint;
    status.targetScreenPt = locPoint;
    [_mapView setMapStatus:status withAnimation:YES];
}

#pragma mark - BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
    [_searchTf resignFirstResponder];
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    if (newState == BMKAnnotationViewDragStateEnding) {
        //        [self reverseGeoCodeWithCoordinate2D:pointAnnotation.coordinate];
    }
}

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"区域将要改变");
    _locationView.hidden = YES;
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    /*
    CGPoint locPoint = CGPointMake(CGRectGetMidX(_addressView.bounds), CGRectGetMaxY(_addressView.bounds));
    CLLocationCoordinate2D loc = [_mapView convertPoint:locPoint toCoordinateFromView:_addressView];
     */
    BMKMapStatus *status = [mapView getMapStatus];
    CLLocationCoordinate2D loc = status.targetGeoPt;
    [self reverseGeoCodeWithCoordinate2D:loc];
    self.location = loc;
}


// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorRed;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        //        annotationView.draggable = self.canEditLocation;
    }
    return annotationView;
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
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
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    [_mapView updateLocationData:userLocation];
    currentUserLocation = userLocation.location.coordinate;
//    if (_canChooseAddress && _location.latitude == 0 && _location.longitude == 0) {
        [self reverseGeoCodeWithCoordinate2D:userLocation.location.coordinate];
        [self gotoGeoPoint:userLocation.location.coordinate];
//    }
    
    _addressView.hidden = NO;
    
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
/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    cityName = result.addressDetail.city;
    _addressLbl.text = result.address;
    _locationView.hidden = NO;
    
    NSLog(@"businessCircle:%@",result.businessCircle);
    NSLog(@"poiList:%@",result.poiList);
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)textDidChange:(id)sender{
    
    if (_searchTf.text.length == 0) {
        _poiTableViewHCstt.constant = 0.;
    }
    
    _poiSearch = [[BMKPoiSearch alloc]init];
    _poiSearch.delegate = self;
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.keyword = _searchTf.text;
    option.city = cityName;
    BOOL flag = [_poiSearch poiSearchInCity:option];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
}

#pragma mark -
#pragma mark - BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        [poiSearchResultArr removeAllObjects];
        [poiSearchResultArr addObjectsFromArray:poiResult.poiInfoList];
        if (poiSearchResultArr.count > 0) {
             _poiTableViewHCstt.constant = 150.;
        }
        [_searchResultTableView reloadData];
    }else{
//        [SVProgressHUD showErrorWithStatus:@"搜索失败"];
    }
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return poiSearchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewPoiCell";
    UITableViewCell *cell = [_searchResultTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.];
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    BMKPoiInfo *info = poiSearchResultArr[indexPath.row];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = info.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [UIView animateWithDuration:0.25 animations:^{
        _poiTableViewHCstt.constant = 0.;
        [self.view layoutIfNeeded];
    }];
    
    [self.view endEditing:YES];
    
    BMKPoiInfo *info = poiSearchResultArr[indexPath.row];
    [self gotoGeoPoint:info.pt];
    _addressLbl.text = info.address;
    _addressView.hidden = NO;
    _locationView.hidden = NO;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.;
}

- (IBAction)onConfirm:(id)sender {
    if ([_delegate respondsToSelector:@selector(chooseAddressController:didGetLocation:andAddress:)]) {
        [_delegate chooseAddressController:self didGetLocation:_location andAddress:_addressLbl.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
