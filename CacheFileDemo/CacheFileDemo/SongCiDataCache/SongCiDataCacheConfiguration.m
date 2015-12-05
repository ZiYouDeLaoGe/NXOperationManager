//
//  SongCiDataCacheConfiguration.m
//  CacheFileDemo
//
//  Created by 李仁兵 on 15/12/5.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import "SongCiDataCacheConfiguration.h"
@implementation SongCiDataCacheConfiguration

+ (NXSearchPathModel)getSearchPathModel
{
    return NXSearchPathModelDocuments;
}

+ (NSString *)getRootFilePath
{
    return @"古诗词.宋词";
}
@end
