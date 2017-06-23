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
#import <MagicalRecord/MagicalRecord.h>

#import "XCTestCase+RCFHelpers.h"

#import "EventObjectTransformer.h"
#import "EventModelObject.h"

@interface EventObjectTransformerTests : XCTestCase

@property (nonatomic, strong) EventObjectTransformer *transformer;

@end

@implementation EventObjectTransformerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.transformer = [EventObjectTransformer new];
}

- (void)tearDown {
    self.transformer = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatTransformerReturnsIdentifierForEvent {
    // given
    NSString *const kTestEventId = @"1234";
    EventModelObject *event = [self generateEventForTestPurposesWithId:kTestEventId];
    
    // when
    NSString *identifier = [self.transformer identifierForObject:event];
    
    // then
    BOOL hasEventId = [identifier rangeOfString:kTestEventId].location != NSNotFound;
    BOOL hasObjectType = [identifier rangeOfString:NSStringFromClass([EventModelObject class])].location != NSNotFound;
    
    XCTAssertNotNil(identifier);
    XCTAssertTrue(hasEventId);
    XCTAssertTrue(hasObjectType);
}

- (void)testThatTransformerReturnsEventForIdentifier {
    // given
    NSString *const kTestEventId = @"1234";
    NSString *const kTestIdentifier = @"EventModelObject_1234";
    [self generateEventForTestPurposesWithId:kTestEventId];
    
    // when
    EventModelObject *event = [self.transformer objectForIdentifier:kTestIdentifier];
    
    // then
    XCTAssertEqualObjects(event.eventId, kTestEventId);
}

- (void)testThatTransfornerDetectsCorrectIdentifier {
    // given
    NSString *const kTestIdentifier = @"EventModelObject_1234";
    
    // when
    BOOL result = [self.transformer isCorrectIdentifier:kTestIdentifier];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatTransformerDetectsIncorrectIdentifier {
    // given
    NSString *const kTestIdentifier = @"1234";
    
    // when
    BOOL result = [self.transformer isCorrectIdentifier:kTestIdentifier];
    
    // then
    XCTAssertFalse(result);
}

#pragma mark - Helper methods

- (EventModelObject *)generateEventForTestPurposesWithId:(NSString *)eventId {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block EventModelObject *object = nil;
    [rootSavingContext performBlockAndWait:^{
        object = [EventModelObject MR_createEntityInContext:rootSavingContext];
        object.eventId = eventId;
        
        [rootSavingContext MR_saveOnlySelfAndWait];
    }];
    return object;
}

@end
