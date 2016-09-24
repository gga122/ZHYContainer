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

#pragma mark - Invocation

- (BOOL)InvocationWithObject:(id<ZHYObject>)object {
    return YES;
}



@end
