//
//  ResourcesAndMetadataViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/18.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ResourcesAndMetadataViewController.h"

@interface ResourcesAndMetadataViewController ()

@end

@implementation ResourcesAndMetadataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资源和元数据";
}

- (void)createAsset {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                id representation = [result defaultRepresentation];
                NSURL *url = [representation url];
                AVAsset *asset = [AVAsset assetWithURL:url];
                NSLog(@"asset :%@", asset);
            }
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error :%@", [error localizedDescription]);
    }];
}

- (void)iPodLibrary {
    MPMediaPropertyPredicate *artistPredicate = [MPMediaPropertyPredicate predicateWithValue:@"Foo fighters" forProperty:MPMediaItemPropertyArtist];
    
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:@"In Your Honor" forProperty:MPMediaItemPropertyAlbumTitle];
    
    MPMediaPropertyPredicate *songPredicate = [MPMediaPropertyPredicate predicateWithValue:@"Foo fighters" forProperty:MPMediaItemPropertyTitle];
    
    MPMediaQuery *query = [[MPMediaQuery alloc] init];
    [query addFilterPredicate:artistPredicate];
    [query addFilterPredicate:albumPredicate];
    [query addFilterPredicate:songPredicate];
    
    NSArray *results = [query items];
    if (results.count > 0) {
        MPMediaItem *item = results[0];
        NSURL *assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
        AVAsset *asset = [AVAsset assetWithURL:assetURL];
        NSLog(@"asset :%@", asset);
    }
}

- (void)keyValueStatusDemo {
    NSURL *assetURL = [[NSBundle mainBundle] URLForResource:@"IMG_4303" withExtension:@"MOV"];
    
    AVAsset *asset = [AVAsset assetWithURL:assetURL];
    NSArray *keys = @[@"tracks"];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:@"status" error:&error];
        switch (status) {
            case AVKeyValueStatusLoaded:
                NSLog(@"Continue Processing");
                break;
            case AVKeyValueStatusFailed:
                NSLog(@"failure with error");
                break;
            case AVKeyValueStatusCancelled:
                NSLog(@"explicit cancellation");
                break;
            default:
                break;
        }
    }];
}

- (void)useMetadataDemo {
    NSURL *assetURL = [[NSBundle mainBundle] URLForResource:@"IMG_4303" withExtension:@"MOV"];
    
    AVAsset *asset = [AVAsset assetWithURL:assetURL];
    NSArray *keys = @[@"availableMetadataFormats"];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSMutableArray *metadata = [[NSMutableArray alloc] init];
        for (NSString *format in asset.availableMetadataFormats) {
            [metadata addObject:[asset metadataForFormat:format]];
        }
    }];
}

- (void)obtainMediaMetadata {
    NSArray *metadata = [NSArray array];
    
    NSString *keySpace = AVMetadataKeySpaceiTunes;
    NSString *artistKey = AVMetadataiTunesMetadataKeyArtist;
    NSString *albumKey = AVMetadataiTunesMetadataKeyAlbum;
    
    NSArray *artistMetadata = [AVMetadataItem metadataItemsFromArray:metadata withKey:artistKey keySpace:keySpace];
    
    NSArray *albumMetadata = [AVMetadataItem metadataItemsFromArray:metadata withKey:albumKey keySpace:keySpace];
    
    AVMetadataItem *artistItem, *albumItem;
    if (artistMetadata.count > 0) {
        artistItem = artistMetadata[0];
    }
    
    if (albumMetadata.count > 0) {
        albumItem = albumMetadata[0];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self keyValueStatusDemo];
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
