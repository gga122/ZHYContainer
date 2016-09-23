//
//  ZHYContainerProtocol.h
//  ZHYContainer
//
//  Created by Henry on 2016/9/23.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYObject.h"

/**
 *  提供了关于ZHYContainer相关接口的定义
 *
 */

@protocol ZHYContainerProtocol <NSObject>

@required

- (BOOL)add:(id<ZHYObject>)object;

- (BOOL)remove:(id<ZHYObject>)object;

@optional



@end
