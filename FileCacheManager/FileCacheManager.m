//
//  FileCacheManager.m
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 李仁兵. All rights reserved.
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

//判断存储条件是否有效
- (BOOL)isConditionValid
{
    if(!self.delegate) {
        //代理不能为空，要根据代理得到存储模式以及存储目录
        return NO;
    }
    if (!self.fileCacheModel) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(failedFileCache:)]) {
            [self.delegate failedFileCache:@"缓存文件数据模型不能为空"];
        }
        return NO;
    }
    if (self.fileCacheModel) {
        if (!self.fileCacheModel.fileData) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(failedFileCache:)]) {
                [self.delegate failedFileCache:@"缓存数据不能为空"];
            }
            return NO;
        }
        if (!self.fileCacheModel.fileName || [self.fileCacheModel.fileName length] == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(failedFileCache:)]) {
                [self.delegate failedFileCache:@"文件名不能为空"];
            }
            return NO;
        }
    }
    return YES;
}

- (void)start
{
    if([self isConditionValid]){
        //存储目录
        NSString * rootDirectoryPath = nil;
        
        //根据存储模式获存储模式取根目录
        switch ([self.delegate searchPathModel]) {
            case NXSearchPathModelDocuments:
                rootDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                break;
            case NXSearchPathModelTemp:
                rootDirectoryPath = NSTemporaryDirectory();
                break;
            case NXSearchPathModelCache:
                rootDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                break;
        }
        
        //根据用户自定义目录获取存储文件目录
        NSString * rootFilePath = [self.delegate rootFilePath];
        if ([rootFilePath length] > 0) {
            NSArray * directories = [rootFilePath componentsSeparatedByString:@"."];
            for (NSString * directory in directories) {
                rootDirectoryPath = [rootDirectoryPath stringByAppendingPathComponent:directory];
            }
        }

        //指定模式下沙盒中是否存在该目录
        if (![_fileManager fileExistsAtPath:rootDirectoryPath]) {
            //如果根目录不存在则建立根目录
            if(![_fileManager createDirectoryAtPath:rootDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil])
            {
                //创建目录失败
                if (self.delegate && [self.delegate respondsToSelector:@selector(failedFileCache:)]) {
                    [self.delegate failedFileCache:@"创建目录失败"];
                }
                return;
            }
        }
        
        //将文件存储到指定目录下
        NSString * filePath = [rootDirectoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",self.fileCacheModel.fileName]];
        if (self.fileCacheModel.fileType) {
            //如果存在文件类型则加上文件类型
            filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@".%@",self.fileCacheModel.fileType]];
        }
        if(![self.fileCacheModel.fileData writeToFile:filePath atomically:YES]){
            if (self.delegate && [self.delegate respondsToSelector:@selector(failedFileCache:)]) {
                [self.delegate failedFileCache:@"数据存储失败"];
            }
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(succedFileCache:)]) {
            [self.delegate succedFileCache:filePath];
        }
        NSLog(@"filePath-------------------%@",filePath);
    }
}
@end
