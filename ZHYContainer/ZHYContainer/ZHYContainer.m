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
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYCommand *> *totalCommands;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYCommand *> *cachedCommands;

@end

@implementation ZHYContainer

#pragma mark - Overridden

- (instancetype)init {
    self = [super init];
    if (self) {
        _globalLock = [[NSRecursiveLock alloc] init];
        
        _totalCommands = [NSMutableDictionary dictionary];
        _cachedCommands = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark - ZHYContainerProtocol

- (BOOL)registerCommand:(ZHYCommand *)cmd forSelector:(SEL)selector {
    BOOL isGuard = (!cmd || selector == nil);
    if (isGuard) {
        return NO;
    }
    
    NSString *selKey = NSStringFromSelector(selector);
    
    ZHYCommand *rCmd = [self commandForSelectorKey:selKey];
    if (rCmd) {
        return NO;
    }

    GLOBAL_LOCK
    
    [self.totalCommands setObject:cmd forKey:selKey];
    
    GLOBAL_UNLOCK
    
    return YES;
}

- (ZHYCommand *)commandForSelector:(SEL)selector {
    if (!selector) {
        return nil;
    }
    
    NSString *selKey = NSStringFromSelector(selector);
    return [self commandForSelectorKey:selKey];
}

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

- (BOOL)remove:(id<ZHYObject>)object {
    if (![self objectWillRemoveBeforeLock:object]) {
        return NO;
    }
    
    GLOBAL_LOCK
    
    BOOL res = [self objectWillRemoveAfterLock:object];
    if (res) {
        res = [self objectDidRemoveAfterLock:object];
    }
    
    GLOBAL_UNLOCK
    
    if (res) {
        return [self objectDidRemoveAfterUnlock:object];
    }
    
    return NO;
}

#pragma mark - Private Method 

- (ZHYCommand *)commandForSelectorKey:(NSString *)selKey {
    if (selKey.length == 0) {
        return nil;
    }
    
    ZHYCommand *cmd;
    
    GLOBAL_LOCK
    cmd = [self.cachedCommands objectForKey:selKey];
    if (!cmd) {
        cmd = [self.totalCommands objectForKey:selKey];
        
        if (cmd) {
            [self.cachedCommands setObject:cmd forKey:selKey];
        }
    }
    
    GLOBAL_UNLOCK
    
    return cmd;
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

#pragma mark - AOP (Remove)

- (BOOL)objectWillRemoveBeforeLock:(id<ZHYObject>)object {
    return NO;
}

- (BOOL)objectWillRemoveAfterLock:(id<ZHYObject>)object {
    return NO;
}

- (BOOL)objectDidRemoveAfterLock:(id<ZHYObject>)object {
    return NO;
}

- (BOOL)objectDidRemoveAfterUnlock:(id<ZHYObject>)object {
    return NO;
}


@end
