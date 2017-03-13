//
//  TLOperationStack.m
//  shuttaV2
//
//  Created by Luan on 8/29/16.
//  Copyright © 2016 shutta. All rights reserved.
//

#import "TLOperationStack.h"

@interface TLOperationStack() <TLTaskDelegate>

@property (atomic) NSOperationQueue *controlQueue;
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) NSMutableArray *stack;
@property (nonatomic) NSMutableDictionary *executingTasks;

@end

@implementation TLOperationStack

- (instancetype)init {
    
    self = [super init];

    // execute the logic of class
    self.controlQueue = [[NSOperationQueue alloc] init];
    self.controlQueue.maxConcurrentOperationCount = 1;
    
    // execute the tasks
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.maxConcurrentcyTasks = 2;
    
    self.stack = [NSMutableArray new];
    self.executingTasks = [NSMutableDictionary new];
    
    return self;
}

- (void)addTask:(TLTask *)task {
    
    if (!task || !task.key) {
        return;
    }
    
    [self.controlQueue addOperationWithBlock:^{
        [self.stack addObject:task];
        task.delegate = self;
//        NSLog(@"add task %@", task.key);
        
        id key = task.key;
        task.operation.completionBlock = ^{
            
            [self.controlQueue addOperationWithBlock:^{
                [self finishedTaskWithId:key];
            }];
        };
        
        [self executeNextTasksIfNeeded];
    }];
}

- (void)cancelAllTasks {
    
    [self.controlQueue addOperationWithBlock:^{
        [self.stack removeAllObjects];
        [self.executingTasks removeAllObjects];
        [self.operationQueue cancelAllOperations];
    }];
}

- (void)finishedTaskWithId:(id)key {
    
//    NSLog(@"finished task %@", key);
    [self.executingTasks removeObjectForKey:key];
    [self executeNextTasksIfNeeded];
}

- (void)executeNextTasksIfNeeded {
    
    NSInteger currentExecutingTasks = self.executingTasks.allKeys.count;
    NSInteger neededTasks = self.maxConcurrentcyTasks - currentExecutingTasks;
    neededTasks = MIN(neededTasks, self.stack.count);
    
    while (neededTasks > 0) {
        TLTask *task = [self.stack lastObject];
//        NSLog(@"start task %@", task.key);
        [self.executingTasks setObject:task forKey:task.key];
        [self.operationQueue addOperation:task.operation];
        [self.stack removeObject:task];
        --neededTasks;
    }
}

#pragma mark - Task Delegate

- (void)taskDidCancel:(TLTask *)task {
    
    if (!task) {
        return;
    }
    
    [self.controlQueue addOperationWithBlock:^{
        
        [task.operation cancel];
        [self.stack removeObject:task];
        [self.executingTasks removeObjectForKey:task.key];
    }];
    
}

@end
