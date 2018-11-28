//
//  YMObtainUserLocationManager.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMObtainUserLocationManager.h"

@interface YMObtainUserLocationManager ()
<CLLocationManagerDelegate,
UIAlertViewDelegate,
UIActionSheetDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locationManager;
/** 目的地地址 */
@property (nonatomic, copy) NSString *toAddress;

@end

@implementation YMObtainUserLocationManager {
    /** 进入设置弹窗 */
    UIAlertView *_alertViewSet;
    /** 进入位置设置弹窗 */
    UIAlertView *_alertViewLoc;
}

static YMObtainUserLocationManager *_instance = nil;
#pragma mark -- 单例
+ (instancetype)shareManager {
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark -- 开始定位
- (void)startLocation:(YMObtainUserLocationManagerLocationBlock)location {
    _ymObtainUserLocationManagerLocationBlock = location;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

#pragma mark -- 定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            if (self.ymObtainUserLocationManagerLocationBlock) {
                self.ymObtainUserLocationManagerLocationBlock(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude, placemark);
            }
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
        } else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    // 系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

#pragma mark -- 判断是否开启了定位权限
- (BOOL)judgeLocationIsUse {
    BOOL isLocation = YES;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        isLocation = NO;
        if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {//判断该软件是否开启定位
            _alertViewSet = [[UIAlertView alloc]initWithTitle:@"打开定位开关" message:@"请点击确定进入App授权" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_alertViewSet show];
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            if (IS_IOS10) {
                _alertViewLoc = [[UIAlertView alloc]initWithTitle:@"打开定位服务" message:@"请点击确定打开系统定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [_alertViewLoc show];
            } else if (IS_IOS10) {
                _alertViewLoc = [[UIAlertView alloc]initWithTitle:@"打开定位服务" message:@"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,允许共享名医使用定位服务" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [_alertViewLoc show];
            }
        }
    } else {
        isLocation = YES;
    }
    return isLocation;
}


#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSURL *url=[[NSURL alloc] init];
        if (alertView==_alertViewSet) {
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        }
        
        if (alertView == _alertViewLoc) {
            url=[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        }
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark -- 调用苹果原生地图先通过目的地逆地理编码得到经纬度
- (void)transferAppLocationWithAddress:(NSString *)oreillyAddress mapType:(YMObtainUserLocationForMap)mapType {
    //下边就是利用CLGeocoder把地理位置信息转换成经纬度坐标；
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        //placemarks就是转换成坐标的数组(当地理位置信息不够准确的时候可能会查询出来几个坐标);
        if ([placemarks count] >0 && error ==nil) {
            NSLog(@"%lu ", (long)[placemarks count]);
            for (int i=0; i<[placemarks count]; i++) {
                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:i];
                //查看CLPlacemark这个类可以看到里边有很多属性；位置的名称等。
                [self gotoMapWithType:mapType address:oreillyAddress coordinate:firstPlacemark.location.coordinate];
            }
        } else if ([placemarks count] ==0 &&
                 error ==nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

#pragma mark -- 通过经纬度调用地图
- (void)gotoMapWithType:(YMObtainUserLocationForMap)mapType address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate {
    switch (mapType) {
        case YMObtainUserLocationForMapApple:
        {
            //当前位置
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            //传入目的地，会显示在苹果自带地图上面目的地一栏
            toLocation.name = address;
            //导航方式选择walking
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }
            break;
        case YMObtainUserLocationForMapBaiDu:
        {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=walking&coord_type=gcj02", coordinate.latitude, coordinate.longitude, address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
            break;
        case YMObtainUserLocationForMapGaoDe:
        {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=2",address, coordinate.latitude, coordinate.longitude, address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
            break;
        case YMObtainUserLocationForMapGoogle:
        {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=walking",
                                     [infoDictionary objectForKey:@"CFBundleDisplayName"],
                                    @"DoctorClient",
                                    coordinate.latitude,
                                    coordinate.longitude]
                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
            break;
        case YMObtainUserLocationForMapTengXun:
        {
            NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=walk&tocoord=%f,%f&to=%@&coord_type=1&policy=0",coordinate.latitude, coordinate.longitude, address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
            break;
            default:
            break;
    }
}

#pragma mark -- 一句话调用地图
- (void)transferMapWithAddress:(NSString *)address view:(UIView *)view {
    self.toAddress = address;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"iPhone 自带地图", @"百度地图", @"高德地图", @"腾讯地图", nil ];
    [sheet showInView:view];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            {
                [self transferAppLocationWithAddress:self.toAddress mapType:YMObtainUserLocationForMapApple];
            }
            break;
        case 1:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                [self transferAppLocationWithAddress:self.toAddress mapType:YMObtainUserLocationForMapBaiDu];
            } else {
                [YMBlackSmallAlert showAlertWithMessage:@"抱歉！您未安装百度地图" time:2.0f];
            }
        }
            break;
        case 2:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
                [self transferAppLocationWithAddress:self.toAddress mapType:YMObtainUserLocationForMapGaoDe];
            } else {
                [YMBlackSmallAlert showAlertWithMessage:@"抱歉！您未安装高德地图" time:2.0f];
            }
        }
            break;
        case 3:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
                [self transferAppLocationWithAddress:self.toAddress mapType:YMObtainUserLocationForMapTengXun];
            } else {
                [YMBlackSmallAlert showAlertWithMessage:@"抱歉！您未安装腾讯地图" time:2.0f];
            }
        }
            break;
        default:
            break;
    }
}

@end
