// Copyright (c) 2016 RAMBLER&Co
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

#import "ReportsSearchViewController.h"
#import "ReportsSearchViewOutput.h"
#import "DataDisplayManager.h"
#import "ReportsSearchDataDisplayManager.h"

#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@interface ReportsSearchTableViewControllerTests : XCTestCase

@property (nonatomic, strong) ReportsSearchViewController *viewController;
@property (nonatomic, strong) ReportsSearchDataDisplayManager *mockDataDisplayManager;
@property (nonatomic, strong) ReportsSearchViewAnimator *mockAnimator;
@property (nonatomic, strong) id <ReportsSearchViewOutput> mockOutput;
@property (nonatomic, strong) UITableView *mockTableView;

@end

@implementation ReportsSearchTableViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [ReportsSearchViewController new];
    self.mockDataDisplayManager = OCMClassMock([ReportsSearchDataDisplayManager class]);
    self.mockOutput = OCMProtocolMock(@protocol(ReportsSearchViewOutput));
    self.mockTableView = OCMClassMock([UITableView class]);
    self.mockAnimator = OCMClassMock([ReportsSearchViewAnimator class]);
    
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.output = self.mockOutput;
    self.viewController.reportsListSearchTableView = self.mockTableView;
    self.viewController.animatorReportsSearchView = self.mockAnimator;
}

- (void)tearDown {
    self.viewController = nil;
    [(id)self.mockDataDisplayManager stopMocking];
    self.mockDataDisplayManager = nil;
    [(id)self.mockOutput stopMocking];
    self.mockOutput = nil;
    [(id)self.mockTableView stopMocking];
    self.mockTableView = nil;
    self.mockAnimator = nil;

    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([self.mockOutput setupView]);
}

#pragma mark - ReportsSearchViewInput


- (void)testSuccessShowClearPlaceholder {
    // given
    
    // when
    [self.viewController showClearPlaceholder];
    
    // then
    OCMVerify([self.mockAnimator showClearPlaceholderWithAnimation]);
}

- (void)testSuccessCloseSearchView {
    // given
    
    // when
    [self.viewController closeSearchView];
    
    // then
    OCMVerify([self.mockAnimator closeSearchViewWithAnimation]);
}

- (void)testSuccessSetupView {
    // given
    
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    id delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForTableView:self.mockTableView withBaseDelegate:nil]).andReturn(delegate);
    
    // when
    [self.viewController setupView];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView setDelegate:delegate]);
}

- (void)testSuccessUpdateViewWithEventList {
    // given
    NSArray *events = @[@1];
    NSString *text = @"SEARCHTEXT";
    // when
    [self.viewController updateViewWithObjectList:events searchText:text];
    
    // then
    OCMVerify([self.mockDataDisplayManager updateTableViewModelWithObjects:events searchText:OCMOCK_ANY]);
}

#pragma mark - ReportsSearchDataDisplayManagerDelegate

- (void)testSuccessDidUpdateTableViewModel {
    // given
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    
    // when
    [self.viewController didUpdateTableViewModel];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView reloadData]);
}

- (void)testSuccessDidTapCellWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.viewController didTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithEvent:event]);
}

- (void)testSuccessDidTapCellWithLecture {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    // when
    [self.viewController didTapCellWithLecture:lecture];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithLecture:lecture]);
}

- (void)testSuccessDidTapCellWithSpeaker {
    // given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    
    // when
    [self.viewController didTapCellWithSpeaker:speaker];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithSpeaker:speaker]);
}

#pragma mark - ReportsSearchViewAnimatorOutput

- (void)testSuccessDidTapClearPlaceholderView{
    // given
    
    // when
    [self.viewController didTapClearPlaceholderView];
    
    // then
    OCMVerify([self.mockOutput didTapClearPlaceholderView]);
}



@end
