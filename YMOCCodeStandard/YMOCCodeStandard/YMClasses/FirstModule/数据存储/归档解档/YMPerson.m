//
//  YMPerson.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMPerson.h"

@implementation YMPerson

#pragma mark - -  NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

#pragma mark - - 保存对象
+ (void)savePerson:(YMPerson *)person fileName:(nonnull NSString *)fileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
}

#pragma mark - - 获取对象
+ (YMPerson *)getPersonWithFileName:(NSString *)fileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    YMPerson *person = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return person;
}

#pragma mark -- 清理指定目录下的缓存
+ (void)removeDocumentWithFileName:(NSString *)fileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:documentPath];

    for (NSString *p in files) {
        NSError *error;
        NSString *path = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if ([p isEqualToString:fileName]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    }
}

@end
