//
//  ZHYContainer.m
//  ZHYContainer
//
//  Created by Henry on 2016/9/23.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ZHYContainer.h"

@interface ZHYContainer ()

@property (nonatomic, strong) NSRecursiveLock *globalLock;

@end

@implementation ZHYContainer

#pragma mark - Overridden

- (instancetype)init {
    self = [super init];
    if (self) {
        _globalLock = [[NSRecursiveLock alloc] init];
    }
    
    return self;
}

@end
