//
//  FileCacheManager.m
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import "FileCacheManager.h"

@implementation FileCacheModel
@end

@interface FileCacheManager ()
{
    NSFileManager * _fileManager;
}
@property (nonatomic,strong) FileCacheModel * fileCacheModel;
@end

@implementation FileCacheManager
- (instancetype)initWithFileModel:(FileCacheModel *)fileCacheModel
{
    if (self == [super init]) {
        self.fileCacheModel = fileCacheModel;
        _fileManager = [NSFileManager defaultManager];
    }
    return self;
}


- (void)start
{
    
}
@end
