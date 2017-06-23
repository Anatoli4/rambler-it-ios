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

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "ServiceComponents.h"
#import "ServiceComponentsAssembly.h"
#import "ServiceComponentsAssembly_Testable.h"

#import "EventServiceImplementation.h"
#import "OperationScheduler.h"
#import "OperationSchedulerImplementation.h"

#import "RamblerLocationServiceImplementation.h"
#import "RamblerInitialAssemblyCollector+Activate.h"
#import "LectureMaterialServiceImplementation.h"

@interface ServiceComponentsAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) ServiceComponentsAssembly *assembly;

@end

@implementation ServiceComponentsAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class class = [ServiceComponentsAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector rds_activateAssemblyWithClass:class];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesEventService {
    // given
    Class targetClass = [EventServiceImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(eventOperationFactory),
                              RamblerSelector(operationScheduler)
                              ];
    // when
    id result = [self.assembly eventService];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesOperationScheduler {
    // given
    Class targetClass = [OperationSchedulerImplementation class];

    // when
    id result = [self.assembly operationScheduler];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor];
}

- (void)testThatAssemblyCreatesRamblerLocationService {
    // given
    Class targetClass = [RamblerLocationServiceImplementation class];
    
    NSArray *dependencies = @[
                              RamblerSelector(client),
                              RamblerSelector(mapper)
                              ];
    
    // when
    id result = [self.assembly ramblerLocationService];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesLectureMaterialService {
    // given
    Class targetClass = [LectureMaterialServiceImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(lectureMaterialDownloadManager),
                              RamblerSelector(fileManager)
                              ];
    // when
    id result = [self.assembly lectureMaterialService];
    
    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

@end
