//
//  FileCacheOperation.m
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import "FileCacheOperation.h"

@interface FileCacheOperation ()
<
NXOperationChildDelegate,
FileCacheManagerDelegate
>
{
    FileCacheModel * _fileCacheModel;
    NXSearchPathModel _searchPathModel;
    NSString * _rootFilePath;
}
@property (nonatomic,strong) FileCacheManager * fileCacheManager;
@property (nonatomic,assign) BOOL isSucced;
@property (nonatomic,copy) NSString * cachePath;

@end

@implementation FileCacheOperation

- (instancetype)initWithFileCacheModel:(FileCacheModel *)fileCacheModel searchPathModel:(NXSearchPathModel)searchPathModel rootFilePath:(NSString *)rootFilePath
{
    self =[super init];
    if (!self) {
        return nil;
    }
    _fileCacheModel = fileCacheModel;
    _searchPathModel = searchPathModel;
    _rootFilePath = rootFilePath;
    return self;
}

- (void)setCompletionBlockWithSuccess:(void (^)(FileCacheOperation *operation, NSString * filePath))success failure:(void (^)(FileCacheOperation *operation ,NSString * errorInfo))failure
{
    __weak typeof(self) weakSelf = self;
    [self setCompletionBlock:^{
        if (weakSelf.isSucced) {
            if (success) {
                success(weakSelf,weakSelf.cachePath);//用户根据需求是否要转到主线程中处理数据
            }
        }else{
            if (failure) {
                failure(weakSelf);
            }
        }
    }];
}

#pragma mark - NXOperationChildDelegate

- (void)startRunFunction
{
    self.fileCacheManager = [[FileCacheManager alloc] initWithFileModel:_fileCacheModel];
    self.fileCacheManager.delegate = self;
    [self.fileCacheManager start];
}

- (void)finishedRunFunction
{
    self.fileCacheManager = nil;
}

#pragma mark - FileCacheManagerDelegate

- (NXSearchPathModel)searchPathModel
{
    return _searchPathModel;
}

- (NSString *)rootFilePath
{
    return _rootFilePath;
}

- (void)succedFileCache:(NSString *)cachePath
{
    self.isSucced = YES;
    self.cachePath = cachePath;
    [self cancel];
}

- (void)failedFileCache:(NSString *)errorInfo
{
    self.isSucced = NO;
    [self cancel];
}



@end
