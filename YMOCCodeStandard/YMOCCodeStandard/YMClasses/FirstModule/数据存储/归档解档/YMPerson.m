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
+ (void)savePerson:(YMPerson *)person {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"person.plist"];
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
}

#pragma mark - - 获取对象
+ (YMPerson *)getPerson {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"person.plist"];
    YMPerson *person = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return person;
}

@end
