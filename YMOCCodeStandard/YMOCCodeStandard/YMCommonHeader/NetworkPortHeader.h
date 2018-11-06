//
//  NetworkPortHeader.h
//  YMDoctorClient
//
//  Created by iOS on 2018/6/15.
//  Copyright © 2018年 iOS. All rights reserved.
//

#ifndef NetworkPortHeader_h
#define NetworkPortHeader_h

#include <Availability.h>
enum  {
    IMG_SOURCE_SMALL = 0,
    IMG_SOURCE_MIDDLE,
    IMG_SOURCE_BIG,
    IMG_SOURCE_CARD_IMG,
};

const static NSString *APIKey = @"e9355a46a595f8b7a5443d17ca184da2";


/// 上传图片
#define DELETE_IMAGE(imageName)       [Utils deleteImageName:imageName]
#define SAVE_IMAGE(imageName,anImage) [Utils saveImageName:imageName image:anImage]
#define GET_IMAGE_PATH(imageName,aType) [Utils getImagePathByName:imageName type:aType]
#define GET_CARD_IMG_PATH(imageName) [Utils getCardImagePathByName:imageName]
#define ADD_FILEPACH(aPath, name) [NSString stringWithFormat:@"%@/%@", aPath, name]
#define DEFAULT_FILEPATH @"imagecache"

#pragma mark － 项目接口 线上

#pragma mark － 项目接口 线下

#pragma mark － 项目接口地址
/** 首页请求 url 后缀 */
static NSString *homeSuffix = @"";


#endif /* NetworkPortHeader_h */
