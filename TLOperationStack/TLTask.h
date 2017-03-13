//
//  TLTask.h
//  shuttaV2
//
//  Created by Luan on 8/29/16.
//  Copyright © 2016 shutta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLTask;
@protocol TLTaskDelegate <NSObject>

- (void)taskDidCancel:(TLTask *)task;

@end

@interface TLTask : NSObject

@property (nonatomic) id key;
@property (nonatomic) NSMutableDictionary *data;
@property (nonatomic) NSOperation *operation;

@property (nonatomic, weak) id<TLTaskDelegate> delegate;

- (void)cancel;

@end
