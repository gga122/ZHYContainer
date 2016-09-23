//
//  ZHYContainer.m
//  ZHYContainer
//
//  Created by Henry on 2016/9/23.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ZHYContainer.h"

#define GLOBAL_LOCK                     [self.globalLock lock];
#define GLOBAL_UNLOCK                   [self.globalLock unlock];

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

#pragma mark - ZHYContainerProtocol

- (BOOL)add:(id<ZHYObject>)object {
    if (![self objectWillAddBeforeLock:object]) {
        return NO;
    }
    
    GLOBAL_LOCK
    
    BOOL res = [self objectWillAddAfterLock:object];
    if (res) {
        res = [self objectDidAddAfterLock:object];
    }
    
    GLOBAL_UNLOCK
    
    if (res) {
        return [self objectDidAddAfterUnlock:object];
    }
    
    return NO;
}

#pragma mark - AOP (Add) 

- (BOOL)objectWillAddBeforeLock:(id<ZHYObject>)object {
    return YES;
}

- (BOOL)objectWillAddAfterLock:(id<ZHYObject>)object {
    return NO;
}

- (BOOL)objectDidAddAfterLock:(id<ZHYObject>)object {
    return NO;
}

- (BOOL)objectDidAddAfterUnlock:(id<ZHYObject>)object {
    return NO;
}

@end
