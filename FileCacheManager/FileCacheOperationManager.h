//
//  FileCacheOperationManager.h
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileCacheOperation.h"

@interface FileCacheOperationManager : NSObject

/*!
 @method - (instancetype)initWithSearchPathModel:(NXSearchPathModel)searchPathModel rootFilePath:(NSString *)rootFilePath;
 @param searchPathModel:NXSearchPathModel,存储模型;
 @param rootFilePath:NSString *,文件存储的根目录,以'.'来间隔文件目录 例如：NX.com.cn 代表目录为 ../NX/com/cn;
 @return FileCacheOperationManager实例对象;
 */
- (instancetype)initWithSearchPathModel:(NXSearchPathModel)searchPathModel rootFilePath:(NSString *)rootFilePath;

/*!
 @method - (void)cacheFileWith:(FileCacheModel *)cacheModel;
 @abstract 执行缓存文件操作;
 @param cacheModel:FileCacheModel,文件数据模型;
 @param success:(void (^)(FileCacheOperation *operation, NSString * filePath)),处理成功数据回调;
 @param failure:(void (^)(FileCacheOperation *operation)),处理失败回调;
 */
- (FileCacheOperation *)cacheFileWith:(FileCacheModel *)fileCacheModel success:(void (^)(FileCacheOperation *operation, NSString * filePath))success failure:(void (^)(FileCacheOperation *operation))failure;
@end
