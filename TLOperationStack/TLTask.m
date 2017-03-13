//
//  TLTask.m
//  shuttaV2
//
//  Created by Luan on 8/29/16.
//  Copyright © 2016 shutta. All rights reserved.
//

#import "TLTask.h"

@implementation TLTask

- (void)cancel {
    
    [self.delegate taskDidCancel:self];
}

@end
