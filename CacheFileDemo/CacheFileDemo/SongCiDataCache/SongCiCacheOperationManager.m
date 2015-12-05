//
//  SongCiCacheOperationManager.m
//  CacheFileDemo
//
//  Created by 李仁兵 on 15/12/5.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import "SongCiCacheOperationManager.h"
#import "SongCiDataCacheConfiguration.h"

@implementation SongCiCacheOperationManager
+ (instancetype)sharedSongciCacheOperationManager
{
    static SongCiCacheOperationManager * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SongCiCacheOperationManager alloc] initWithSearchPathModel:[SongCiDataCacheConfiguration getSearchPathModel] rootFilePath:[SongCiDataCacheConfiguration getRootFilePath]];
    });
    return _sharedClient;
}
@end
