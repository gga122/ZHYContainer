//
//  ZHYContainer.h
//  ZHYContainer
//
//  Created by Henry on 2016/9/23.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYContainerProtocol.h"

/**
 *  提供了通用型的线程安全数据容器
 *
 */

@interface ZHYContainer : NSObject <ZHYContainerProtocol>


- (BOOL)add:(id<ZHYObject>)object;

/**
 *  提供添加接口相关的AOP方法, 返回 ‘NO’ 将返回
 */
- (BOOL)objectWillAddBeforeLock:(id<ZHYObject>)object;
- (BOOL)objectWillAddAfterLock:(id<ZHYObject>)object;
- (BOOL)objectDidAddAfterLock:(id<ZHYObject>)object;
- (BOOL)objectDidAddAfterUnlock:(id<ZHYObject>)object;



@end
