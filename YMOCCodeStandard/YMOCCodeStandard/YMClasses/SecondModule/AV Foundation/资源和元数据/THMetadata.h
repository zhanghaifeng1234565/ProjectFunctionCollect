//
//  THMetadata.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/22.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class THGenre;
@interface THMetadata : NSObject

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *artist;
@property (nonatomic, readwrite, copy) NSString *albumArtist;
@property (nonatomic, readwrite, copy) NSString *album;
@property (nonatomic, readwrite, copy) NSString *grouping;
@property (nonatomic, readwrite, copy) NSString *composer;
@property (nonatomic, readwrite, copy) NSString *comments;
@property (nonatomic, readwrite, strong) NSImage *artwork;
@property (nonatomic, readwrite, strong) THGenre *genre;

@property (nonatomic, readwrite, copy) NSString *year;
@property (nonatomic, readwrite, strong) NSNumber *bpm;
@property (nonatomic, readwrite, strong) NSNumber *trackNumber;
@property (nonatomic, readwrite, strong) NSNumber *trackCount;
@property (nonatomic, readwrite, strong) NSNumber *disNumber;
@property (nonatomic, readwrite, strong) NSNumber *disCount;

- (void)addMetadataItem:(AVMetadataItem *)item withKey:(id)key;
- (NSArray *)metadataItems;
@end

NS_ASSUME_NONNULL_END
