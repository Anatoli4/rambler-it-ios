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

#import "EventGalleryEventCollectionViewCell.h"

#import "EventGalleryEventCollectionViewCellObject.h"
#import "EXTScope.h"
#import "EventGalleryCollectionViewCellShadower.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

@implementation EventGalleryEventCollectionViewCell

#pragma mark - <NICollectionViewCell>

- (BOOL)shouldUpdateCellWithObject:(EventGalleryEventCollectionViewCellObject *)object {
    self.eventTitleLabel.text = object.eventTitle;
    self.eventDescriptionLabel.text = object.eventDescription;
    self.eventDateLabel.text = object.eventDate;
    self.eventTimeLabel.text = object.eventTime;
    
    self.eventLogoImageView.tintColor = object.primaryColor;
    
    NSURL *imageUrl = [NSURL URLWithString:object.eventImageUrl];
    @weakify(self);
    [self.eventLogoImageView sd_setImageWithURL:imageUrl
                               placeholderImage:[UIImage imageNamed:kPlaceholderImageName]
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          @strongify(self);
                                          self.eventLogoImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                                      }];
    
    [self setupShadows];
    
    return YES;
}

- (void)setupShadows {
    EventGalleryCollectionViewCellShadower *shadower = [EventGalleryCollectionViewCellShadower new];
    [shadower applyShadowOnView:self];
}

@end
