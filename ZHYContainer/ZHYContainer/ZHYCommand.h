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

@end


@protocol ZHYCommandDelegate <NSObject>

@end
