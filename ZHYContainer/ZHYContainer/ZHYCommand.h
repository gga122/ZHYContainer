//
//  ZHYCommand.h
//  ZHYContainer
//
//  Created by Henry on 2016/9/25.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYContainerProtocol.h"

@protocol ZHYCommandDelegate;

/**
 *  提供了容器通用业务操作指令
 */

@interface ZHYCommand : NSObject

- (instancetype)initWithCommandID:(NSInteger)cmdID delegate:(id<ZHYCommandDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) NSInteger commandID;
@property (nonatomic, weak) id<ZHYCommandDelegate> delegate;

@property (nonatomic, strong) id<NSLocking> lock;

@property (nonatomic, weak) id<ZHYContainerProtocol> container;

/**
 *  用于指令操作AOP的相关接口
 *  子类可以重写这些方法来实现通用指令处理操作
 *
 *  1. Will Process (Unlock)
 *  2. Will Process (Lock)
 *  3. Did  Process (Lock)
 *  4. Did  Process (Unlock)
 */
- (BOOL)objectWillProcessBeforeLock:(id<ZHYObject>)object;
- (BOOL)objectWillProcessAfterLock:(id<ZHYObject>)object;
- (BOOL)objectDidProcessAfterLock:(id<ZHYObject>)object;
- (BOOL)objectDidProcessAfterUnlock:(id<ZHYObject>)object;

@end


@protocol ZHYCommandDelegate <NSObject>

@optional
- (BOOL)command:(ZHYCommand *)cmd willProcessBeforeLockWith:(id<ZHYObject>)object;
- (BOOL)command:(ZHYCommand *)cmd willProcessAfterLockWith:(id<ZHYObject>)object;
- (BOOL)command:(ZHYCommand *)cmd didProcessAfterLockWith:(id<ZHYObject>)object;
- (BOOL)command:(ZHYCommand *)cmd didProcessAfterUnlockWith:(id<ZHYObject>)object;

@end
