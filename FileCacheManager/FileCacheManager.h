//
//  FileCacheManager.h
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,NXSearchPathModel)
{
    NXSearchPathModelDocuments = 0, //存放在沙盒Documents目录下,应用中用户数据存放、iTunes备份和恢复的时候在此模式下进行
    NXSearchPathModelTemp,          //存放在沙盒临时目录下,此模式目录下文件可能会在应用退出后删除
    NXSearchPathModelCache          //存放在沙盒缓存目录下,此模式目录下文件不会在应用退出删除
};

@interface FileCacheModel : NSObject
@property (nonatomic,copy) NSString * fileName; //文件名字
@property (nonatomic,strong) NSData *fileData;  //文件数据
@property (nonatomic,copy) NSString * fileType; //文件类型，html/jpg/png/text等
@end

@protocol FileCacheManagerDelegate <NSObject>

@required
/*!
 @method - (NXSearchPathModel)searchPathModel;
 @abstract 存放模型
 @return NXSearchPathModel模型
 */
- (NXSearchPathModel)searchPathModel;

/*!
 @method - (NSString *)rootFilePath;
 @abstract 获取根目录
 @return NSString * 根目录
 */
- (NSString *)rootFilePath;

@optional
/*!
 @method - (void)succedFileCache;
 @abstract 缓存文件成功
 @param cachePath:NSString *,本地路径
 @return void
 */
- (void)succedFileCache:(NSString *)cachePath;

/*!
 @method - (void)failedFileCache;
 @abstract 缓存文件失败
 @return void
 */
- (void)failedFileCache:(NSString *)errorInfo;
@end

@interface FileCacheManager : NSObject
@property (nonatomic,weak) id<FileCacheManagerDelegate> delegate;
- (instancetype)initWithFileModel:(FileCacheModel *)fileCacheModel;

/*!
 @method - (void)start;
 @abstract 启动缓存文件
 @return void
 */
- (void)start;
@end
