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

#import "LectureInfoTableViewCell.h"
#import "LectureInfoTableViewCellObject.h"
#import "LectureInfoTableViewCellActionProtocol.h"
#import "EventTableViewCellActionProtocol.h"
#import "Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"
#import "UIFont+RIDTypefaces.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"speaker-placeholder";

@interface LectureInfoTableViewCell ()

@property (nonatomic, weak) id <LectureInfoTableViewCellActionProtocol> actionProxy;
@property (nonatomic, strong) LectureInfoTableViewCellObject *cellObject;

@end

@implementation LectureInfoTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<LectureInfoTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(LectureInfoTableViewCellActionProtocol)];
    UITapGestureRecognizer *speakerViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSpeakerView:)];
    [self.speakerView addGestureRecognizer:speakerViewTapRecognizer];
    self.lectureTitle.font = [UIFont rid_lectureTitleFont];
    self.lectureDescription.font = [UIFont rid_lectureDescriptionFont];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(LectureInfoTableViewCellObject *)object {
    self.cellObject = object;
    self.speakerName.text = object.speakerName;
    self.speakerCompanyName.text = object.speakerCompanyName;
    self.lectureDescription.text = object.lectureDescription;
    self.lectureTitle.text = object.lectureTitle;
    
    self.speakerImageView.layer.cornerRadius = self.speakerImageView.frame.size.height / 2;
    self.speakerImageView.clipsToBounds = YES;
    [self.speakerImageView sd_setImageWithURL:object.speakerImageUrl
                             placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
    [self.tapRecognizer setCancelsTouchesInView:NO];
    
    if (!object.continueReadingFlag) {
        self.continueReadingButton.hidden = YES;
        self.lectureDescriptionTOBottomConstraint.priority = UILayoutPriorityDefaultHigh;
    }
    
    return YES;
}

+ (CGFloat)heightForObject:(LectureInfoTableViewCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return object.height;
}

#pragma mark - IBActions

- (void)didTapSpeakerView:(id)sender {
    [self.actionProxy didSpeakerViewWithSpeakerId:self.cellObject.speakerId];
}

@end
