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

#import "ReportSpeakerTableViewCellObject.h"
#import "ReportSpeakerTableViewCell.h"
#import "SpeakerPlainObject.h"
#import "UIColor+ConferencesPalette.h"

@interface ReportSpeakerTableViewCellObject ()

@property (nonatomic, strong, readwrite) NSAttributedString *speakerName;
@property (nonatomic, strong, readwrite) NSString *company;
@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, strong, readwrite) SpeakerPlainObject *speaker;

@end

@implementation ReportSpeakerTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithSpeaker:(SpeakerPlainObject *)speaker attributedName:(NSAttributedString *)attributedName{
    self = [super init];
    if (self) {
        _speakerName = attributedName;
        _company = speaker.company;
        _speakerImage = nil;
        _speaker = speaker;
        _imageURL = [NSURL URLWithString:speaker.imageUrl];
    }
    return self;
}

+ (instancetype)objectWithSpeaker:(SpeakerPlainObject *)speaker highlightedText:(NSAttributedString *)highlightedText {

    return [[self alloc] initWithSpeaker:speaker attributedName:highlightedText];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportSpeakerTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportSpeakerTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
