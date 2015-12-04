//
//  NXOperation.h
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NXOperationChildDelegate <NSObject>
@required
/*!
 @method - (void)startRunFunction;
 @abstract 开始执行功能
 @return void
 */
- (void)startRunFunction;

/*!
 @method - (void)finishedRunFunction;
 @abstract 结束执行功能
 @return void
 */
- (void)finishedRunFunction;
@end

@interface NXOperation : NSOperation

@end
