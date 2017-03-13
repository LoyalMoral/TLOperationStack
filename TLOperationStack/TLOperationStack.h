//
//  TLOperationStack.h
//  shuttaV2
//
//  Created by Luan on 8/29/16.
//  Copyright © 2016 shutta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLTask.h"

@interface TLOperationStack : NSObject

@property (nonatomic) NSInteger maxConcurrentcyTasks;

- (void)addTask:(TLTask *)task;
- (void)cancelAllTasks;

@end
