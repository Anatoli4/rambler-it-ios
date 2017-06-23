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

#import "SignUpAndSaveToCalendarEventTableViewCell.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellActionProtocol.h"
#import "EventTableViewCellActionProtocol.h"
#import "Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

static CGFloat const kSignUpAndSaveToCalendarEventTableViewCellHeight = 164.0f;
static CGFloat const kSaveToCalendarButtonBorderWidth = 1.0f;

@interface SignUpAndSaveToCalendarEventTableViewCell ()

@property (nonatomic, weak) IBOutlet UIButton *signUpButton;
@property (nonatomic, weak) IBOutlet UIButton *saveToCalendarButton;

@property (nonatomic, weak) id <SignUpAndSaveToCalendarEventTableViewCellActionProtocol> actionProxy;

@property (nonatomic, strong) SignUpAndSaveToCalendarEventTableViewCellObject *cellObject;

@end

@implementation SignUpAndSaveToCalendarEventTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<SignUpAndSaveToCalendarEventTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(SignUpAndSaveToCalendarEventTableViewCellObject *)object {
    self.cellObject = object;
    self.signUpButton.enabled = NO;
    
    [self.saveToCalendarButton setTitleColor:object.buttonColor forState:UIControlStateNormal];
    self.saveToCalendarButton.layer.borderColor = object.buttonColor.CGColor;
    self.saveToCalendarButton.layer.borderWidth = kSaveToCalendarButtonBorderWidth;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kSignUpAndSaveToCalendarEventTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapSignUpButton:(UIButton *)sender {
    [self.actionProxy didTapSignUpButtonWithEvent:self.cellObject.event];
}

- (IBAction)didTapSaveToCalendarButton:(UIButton *)sender {
    [self.actionProxy didTapSaveToCalendarButtonWithEvent:self.cellObject.event];
}

@end
