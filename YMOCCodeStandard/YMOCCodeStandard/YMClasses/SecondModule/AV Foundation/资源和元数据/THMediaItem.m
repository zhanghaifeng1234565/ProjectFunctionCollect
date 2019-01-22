//
//  THMediaItem.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/22.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "THMediaItem.h"
#import "AVMetadataItem+THAdditions.h"
#import "NSFileManager+DirectoryLocations.h"

#define COMMON_META_KEY @"commonMetadata"
#define AVAILABLE_META_KEY @"availableMetadataFormats"

@interface THMediaItem ()

@property (nonatomic, readwrite, assign) NSURL *url;
@property (nonatomic, readwrite, strong) AVAsset *asset;
@property (nonatomic, readwrite, strong) THMetadata *metadata;
@property (nonatomic, readwrite, strong) NSArray *acceptedFormats;
@property (nonatomic, readwrite, assign) BOOL prepared;

@end

@implementation THMediaItem

- (id)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        _url = url;
        _asset = [AVAsset assetWithURL:url];
        
        _filename = [url lastPathComponent];
        _filetype = [self fileTypeForURL:url];
        _editable = ![_filetype isEqualToString:AVFileTypeMPEGLayer3];
        _acceptedFormats = @[
            AVMetadataFormatQuickTimeMetadata,
            AVMetadataFormatiTunesMetadata,
            AVMetadataFormatID3Metadata
        ];
    }
    return self;
}

- (NSString *)fileTypeForURL:(NSURL *)url {
    NSString *ext = [[self.url lastPathComponent] pathExtension];
    NSString *type = nil;
    if ([ext isEqualToString:@"m4a"]) {
        type = AVFileTypeAppleM4A;
    } else if ([ext isEqualToString:@"m4a"]) {
        type = AVFileTypeAppleM4V;
    } else if ([ext isEqualToString:@"mov"]) {
        type = AVFileTypeQuickTimeMovie;
    } else if ([ext isEqualToString:@"mp4"]) {
        type = AVFileTypeMPEG4;
    } else {
        type = AVFileTypeMPEGLayer3;
    }
    return type;
}

- (void)prepareWithCompletionHandler:(THCompletionHandler)handler {
    if (self.prepared) {
        handler(self.prepared);
        return;
    }
    
    self.metadata = [[THMetadata alloc] init];
    NSArray *keys = @[COMMON_META_KEY, AVAILABLE_META_KEY];
    [self.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        AVKeyValueStatus commonStatus = [self.asset statusOfValueForKey:COMMON_META_KEY error:nil];
        AVKeyValueStatus formatStatus = [self.asset statusOfValueForKey:AVAILABLE_META_KEY error:nil];
        
        self.prepared = (commonStatus == AVKeyValueStatusLoaded) && (formatStatus == AVKeyValueStatusLoaded);
        if (self.prepared) {
            for (AVMetadataItem *item in self.asset.commonMetadata) {
                [self.metadata addMetadataItem:item withKey:item.commonKey];
            }
        }
        
        for (id format in self.asset.availableMetadataFormats) {
            NSArray *items = [self.asset metadataForFormat:format];
            if ([self.acceptedFormats containsObject:format]) {
                for (AVMetadataItem *item in items) {
                    [self.metadata addMetadataItem:item withKey:item.ym_keyString];
                }
            }
        }
        
        handler(self.prepared);
    }];
}

@end
