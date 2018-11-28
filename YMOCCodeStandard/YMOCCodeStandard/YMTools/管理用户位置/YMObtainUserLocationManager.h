//
//  YMObtainUserLocationManager.h
//  YMDoctorClient
//
//  Created by iOS on 2018/6/25.
//  Copyright © 2018年 iOS. All rights reserved.
//
/*
 这里提供一个仅仅使用苹果原生地图，的方法
 NSString *oreillyAddress = @"东三旗安康便利超市";
 
 //下边就是利用CLGeocoder把地理位置信息转换成经纬度坐标；
 CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
 [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray*placemarks,NSError *error) {
 //placemarks就是转换成坐标的数组(当地理位置信息不够准确的时候可能会查询出来几个坐标);
 if ([placemarks count] >0 && error ==nil) {
 
 NSLog(@"%lu ", (long)[placemarks count]);
 NSMutableArray *arrtemp=[[NSMutableArray alloc]initWithCapacity:0];
 
 for (int i=0; i<[placemarks count]; i++) {
 CLPlacemark *firstPlacemark = [placemarks objectAtIndex:i];
 //查看CLPlacemark这个类可以看到里边有很多属性；位置的名称等。
 
 //下面就是来调用苹果地图应用了；
 MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude)addressDictionary:nil]];
 toLocation.name=firstPlacemark.name;
 [arrtemp addObject:toLocation];
 }
 //打开地图
 //1.搜索位置；
 //[MKMapItem openMapsWithItems:arrtemp launchOptions:nil];
 //2.查询线路；
 MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];//当前位置
 NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithCapacity:0];
 if (@available(iOS 9.0, *)) {
 [dict setObject:MKLaunchOptionsDirectionsModeTransit forKey:MKLaunchOptionsDirectionsModeKey];
 } else {
 [dict setObject:MKLaunchOptionsDirectionsModeWalking forKey:MKLaunchOptionsDirectionsModeKey];
 }
 [dict setObject:[NSNumber numberWithBool:YES]forKey:MKLaunchOptionsShowsTrafficKey];
 
 [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, [arrtemp objectAtIndex:0],nil]launchOptions:dict];
 //MKLaunchOptionsDirectionsModeKey方式:步行，开车
 //MKLaunchOptionsShowsTrafficKey  显示交通状况
 //MKMapItem 进去后看其他属性
 }
 else if ([placemarks count] ==0 &&
 error ==nil) {
 NSLog(@"Found no placemarks.");
 }
 else if (error !=nil) {
 NSLog(@"An error occurred = %@", error);
 }
 }];
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YMObtainUserLocationForMap) {
    /** 苹果自带地图 */
    YMObtainUserLocationForMapApple = 0,
    /** 百度地图 */
    YMObtainUserLocationForMapBaiDu = 1,
    /** 高德地图 */
    YMObtainUserLocationForMapGaoDe = 2,
    /** 谷歌地图 国内不能使用 */
    YMObtainUserLocationForMapGoogle = 3,
    /** 腾讯地图 */
    YMObtainUserLocationForMapTengXun = 4,
};

typedef void(^YMObtainUserLocationManagerLocationBlock)(CLLocationDegrees lat, CLLocationDegrees lng, CLPlacemark *placemark);
@interface YMObtainUserLocationManager : NSObject

/**
 单例全局共享

 @return 单例
 */
+ (instancetype)shareManager;

/** 获取用户所在文字的经纬度 */
@property (nonatomic, copy) YMObtainUserLocationManagerLocationBlock ymObtainUserLocationManagerLocationBlock;

/**
 开始定位获取位置信息

 @param location 回调位置信息
 */
- (void)startLocation:(YMObtainUserLocationManagerLocationBlock)location;

/**
 判断是否开启了定位权限

 @return 开启结果 YES 开启 NO 未开启
 */
- (BOOL)judgeLocationIsUse;


/**
 调用地图查询线路

 @param oreillyAddress 要查询的地址
 @param mapType 地图类型
 */
- (void)transferAppLocationWithAddress:(NSString *)oreillyAddress mapType:(YMObtainUserLocationForMap)mapType;

/**
 调用地图

 @param address 要查询的地址
 @param view 要展示的视图上
 */
- (void)transferMapWithAddress:(NSString *)address view:(UIView *)view;
@end
