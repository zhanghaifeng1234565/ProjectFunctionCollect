//
//  THMediaItem.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/22.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THMetadata.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^THCompletionHandler)(BOOL complete);

@interface THMediaItem : NSObject

@property (nonatomic, readonly, copy) NSString *filename;
@property (nonatomic, readonly, copy) NSString *filetype;
@property (nonatomic, readonly, strong) THMetadata *metadata;
@property (nonatomic, readonly, assign, getter=isEditable) BOOL editable;

- (id)initWithURL:(NSURL *)url;

- (void)prepareWithCompletionHandler:(THCompletionHandler)handler;
- (void)saveWithCompletionHandler:(THCompletionHandler)handler;

@end

NS_ASSUME_NONNULL_END
