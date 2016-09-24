//
//  ZHYContainerProtocol.h
//  ZHYContainer
//
//  Created by Henry on 2016/9/23.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYCommand.h"
#import "ZHYObject.h"

/**
 *  提供了关于ZHYContainer相关接口的定义
 *
 */

@protocol ZHYContainerProtocol <NSObject>

@required

- (BOOL)registerCommand:(ZHYCommand *)cmd forSelector:(SEL)selector;

- (BOOL)add:(id<ZHYObject>)object;

- (BOOL)remove:(id<ZHYObject>)object;

- (BOOL)contains:(id<ZHYObject>)object;

@property (nonatomic) NSEnumerator<id<ZHYObject>> *objectEnumerator;

@optional

- (BOOL)update:(id<ZHYObject>)object;

- (BOOL)cover:(id<ZHYContainerProtocol>)container;

+ (instancetype)containerWithContainer:(id<ZHYContainerProtocol>)container;

@end
