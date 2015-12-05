//
//  NXOperation.m
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import "NXOperation.h"

typedef NS_ENUM(NSInteger, NXOperationState) {
    NXOperationStateReady     = 0, //准备好状态
    NXOperationStateExecuting = 1, //正在运行状态
    NXOperationStateFinished  = 2, //结束状态
};

static inline NSString * NXKeyPathFromOperationState(NXOperationState state) {
    switch (state) {
        case NXOperationStateReady:
            return @"isReady";
        case NXOperationStateExecuting:
            return @"isExecuting";
        case NXOperationStateFinished:
            return @"isFinished";
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            return @"state";
#pragma clang diagnostic pop
        }
    }
}

static inline BOOL NXStateTransitionIsValid(NXOperationState fromState, NXOperationState toState, BOOL isCancelled) {
    switch (fromState) {
        case NXOperationStateReady:
            switch (toState) {
                case NXOperationStateExecuting:
                    return YES;
                case NXOperationStateFinished:
                    return isCancelled;
                default:
                    return NO;
            }
        case NXOperationStateExecuting:
            switch (toState) {
                case NXOperationStateFinished:
                    return YES;
                default:
                    return NO;
            }
        case NXOperationStateFinished:
            return NO;
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            switch (toState) {
                case NXOperationStateReady:
                case NXOperationStateExecuting:
                case NXOperationStateFinished:
                    return YES;
                default:
                    return NO;
            }
        }
#pragma clang diagnostic pop
    }
}

@interface NXOperation ()
@property (nonatomic,assign) NXOperationState state;
@property (nonatomic,weak) id<NXOperationChildDelegate> child;
@end

@implementation NXOperation
@synthesize state = _state;

- (instancetype)init
{
    self =[super init];
    if (!self) {
        return nil;
    }
    if ([self conformsToProtocol:@protocol(NXOperationChildDelegate) ]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.child = self;
#pragma clang diagnostic pop
    }else{
        NSLog(@"NXOperation子类必须实现NXOperationChildDelegate协议");
        return nil;
    }
    self.state = NXOperationStateReady;
    return self;
}

#pragma mark - Over Ride

- (void)start
{
    if(self.isCancelled){
        //当前线程取消的话则结束线程
        [self finish];
        return;
    }
    self.state = NXOperationStateExecuting;
    [self.child startRunFunction];
}

- (void)cancel
{
    if(![self isExecuting])
        //如果不是正在进行，则是停止或取消了
        return;
    //如果程序正在进行则取消
    [super cancel];
    [self finish];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.state == NXOperationStateExecuting;
}

- (BOOL)isFinished
{
    return self.state == NXOperationStateFinished;
}

//状态是否准备好了
- (BOOL)isReady
{
    return self.state == NXOperationStateReady;
}
#pragma mark - 自定义函数

//结束函数
- (void)finish
{
    [self.child finishedRunFunction];
    self.state = NXOperationStateFinished;
}

- (NXOperationState)state
{
    @synchronized(self) {
        return _state;
    }
}

- (void)setState:(NXOperationState)newState
{
    if (!NXStateTransitionIsValid(self.state, newState, [self isCancelled])) {
        return;
    }
    @synchronized(self) {
        NSString *oldStateKey = NXKeyPathFromOperationState(self.state);
        NSString *newStateKey = NXKeyPathFromOperationState(newState);
        [self willChangeValueForKey:newStateKey];
        [self willChangeValueForKey:oldStateKey];
        _state = newState;
        [self didChangeValueForKey:oldStateKey];
        [self didChangeValueForKey:newStateKey];
    }
}
@end
