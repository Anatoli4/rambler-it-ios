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
#import <OCMock/OCMock.h>
#import "TagCollectionViewCell.h"
#import "TagCollectionViewCellObject.h"

@interface TagCollectionViewCellTests : XCTestCase

@property (nonatomic, strong) TagCollectionViewCell *cell;
@property (nonatomic, strong) id mockLabel;

@end

@implementation TagCollectionViewCellTests

- (void)setUp {
    [super setUp];

    self.cell = [TagCollectionViewCell new];
    self.mockLabel = OCMClassMock([UILabel class]);

    self.cell.tagLabel = self.mockLabel;
}

- (void)tearDown {

    self.cell = nil;

    self.mockLabel = nil;

    [super tearDown];
}

- (void)testConfigureCell {
    // given
    NSString *tagName = @"tag 1";
    id cellObject = [[TagCollectionViewCellObject alloc] initWithTagName:tagName];

    // when
    [self.cell shouldUpdateCellWithObject:cellObject];

    // then
    OCMVerify([self.mockLabel setText:tagName]);
}

@end
