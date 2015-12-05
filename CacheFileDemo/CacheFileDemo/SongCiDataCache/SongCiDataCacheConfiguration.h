//
//  SongCiDataCacheConfiguration.h
//  CacheFileDemo
//
//  Created by 李仁兵 on 15/12/5.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileCacheOperationManager.h"

@interface SongCiDataCacheConfiguration : NSObject
+ (NXSearchPathModel)getSearchPathModel;
+ (NSString *)getRootFilePath;
@end
