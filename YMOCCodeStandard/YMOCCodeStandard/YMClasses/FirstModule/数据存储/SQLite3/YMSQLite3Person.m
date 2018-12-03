//
//  YMSQLite3Person.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/3.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMSQLite3Person.h"

@implementation YMSQLite3Person

static int count = 0;
- (NSString *)itemid {
    if (count <= 0) {
        count = 0;
    }
    
    if (self.isDeleteData == YES) {
        count--;
    } else {
        count++;
    }
    NSLog(@"itemid = %@", [NSString stringWithFormat:@"%d", count]);
    return [NSString stringWithFormat:@"%d", count];
}

- (void)setItemid:(NSString *)itemid {
    count = [itemid intValue];
}

- (void)setDelete_data:(BOOL)delete_data {
    _delete_data = delete_data;
}

@end
