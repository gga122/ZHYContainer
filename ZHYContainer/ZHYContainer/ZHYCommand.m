//
//  ZHYCommand.m
//  ZHYContainer
//
//  Created by Henry on 2016/9/25.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ZHYCommand.h"

@implementation ZHYCommand

#pragma mark - NS_DESIGNATED_INITIALIZER

- (instancetype)initWithCommandID:(NSInteger)cmdID delegate:(id<ZHYCommandDelegate>)delegate {
    self = [super init];
    if (self) {
        _commandID = cmdID;
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark - Overridden

- (instancetype)init {
    return [self initWithCommandID:0 delegate:nil];
}

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<CommandID: %zd>", _commandID];
    
    return desc;
}

#pragma mark - Invocation

- (BOOL)InvocationWithObject:(id<ZHYObject>)object {
    id<NSLocking> lock = self.lock;
    
    if (!lock) {
        [NSException raise:NSObjectNotAvailableException format:@"lock object is nil. <Command: %@>", self];
        return NO;
    }
    
    if (![self objectWillProcessBeforeLock:object]) {
        return NO;
    }
    
    [lock lock];
    
    BOOL res = [self objectWillProcessAfterLock:object];
    if (res) {
        res = [self objectDidProcessAfterLock:object];
    }
    
    [lock unlock];
    
    if (res) {
        return [self objectDidProcessAfterUnlock:object];
    }
    
    return NO;
}

#pragma mark - AOP (Process)

- (BOOL)objectWillProcessBeforeLock:(id<ZHYObject>)object {
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:willProcessBeforeLockWith:)]) {
        return [self.delegate command:self willProcessBeforeLockWith:object];
    }
    
    return NO;
}

- (BOOL)objectWillProcessAfterLock:(id<ZHYObject>)object {
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:willProcessAfterLockWith:)]) {
        return [self.delegate command:self willProcessAfterLockWith:object];
    }
    
    return NO;
}

- (BOOL)objectDidProcessAfterLock:(id<ZHYObject>)object {
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:didProcessAfterLockWith:)]) {
        return [self.delegate command:self didProcessAfterLockWith:object];
    }
    
    return NO;
}

- (BOOL)objectDidProcessAfterUnlock:(id<ZHYObject>)object {
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:didProcessAfterUnlockWith:)]) {
        return [self.delegate command:self didProcessAfterUnlockWith:object];
    }
    
    return NO;
}

@end
