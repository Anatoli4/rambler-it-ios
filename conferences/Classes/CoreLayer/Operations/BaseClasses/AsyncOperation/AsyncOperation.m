// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AsyncOperation.h"

static NSString *const kExecutingFlagSelector = @"isExecuting";
static NSString *const kFinishedFlagSelector = @"isFinished";

@implementation AsyncOperation {
    BOOL        executing;
    BOOL        finished;
};

- (instancetype)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

#pragma mark - Getters

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

#pragma mark - Private methods

- (void)start {
    /**
     @author Egor Tolstoy
     
     Always check, if the operation was cancelled before the start
     */
    if ([self isCancelled])
    {
        /**
         @author Egor Tolstoy
         
         If it was cancelled, we are switching it to finished state
         */
        [self willChangeValueForKey:kFinishedFlagSelector];
        finished = YES;
        [self didChangeValueForKey:kFinishedFlagSelector];
        return;
    }
    
    /**
     @author Egor Tolstoy
     
     If it wasn't cancelled, we're beginning the task
     */
    [self willChangeValueForKey:kExecutingFlagSelector];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:kExecutingFlagSelector];
}

- (void)main {
    [NSException raise:NSInternalInconsistencyException
                format:@"You should override the method %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)complete {
    /**
     @author Egor Tolstoy
     
     We should always manually setup finished and executing flags after the operation is complete
     */
    [self willChangeValueForKey:kFinishedFlagSelector];
    [self willChangeValueForKey:kExecutingFlagSelector];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:kExecutingFlagSelector];
    [self didChangeValueForKey:kFinishedFlagSelector];
}

@end
