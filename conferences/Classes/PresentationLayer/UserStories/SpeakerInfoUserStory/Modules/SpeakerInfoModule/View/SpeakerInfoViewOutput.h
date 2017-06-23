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

#import <Foundation/Foundation.h>

@class LecturePlainObject;

@protocol SpeakerInfoViewOutput <NSObject>

/**
 @author Egor Tolstoy
 
 Method is used for initial view setup
 */
- (void)setupView;

/**
 @author Egor Tolstoy
 
 Method tells output that a social network element was tapped
 
 @param socialUrl The social network URL
 */
- (void)didTriggerSocialNetworkTapEventWithUrl:(NSURL *)socialUrl;

/**
 @author Egor Tolstoy
 
 Method tells output that an email element was tapped
 
 @param email The receiver email
 */
- (void)didTriggerEmailTapEventWithEmail:(NSString *)email;

/**
 @author Egor Tolstoy
 
 Method tells output that a lecture element was tapped
 
 @param lecture Lecture model object
 */
- (void)didTriggerLectureTapEventWithLecture:(LecturePlainObject *)lecture;

/**
 @author Egor Tolstoy
 
 Method tells presenter that share button was tapped
 */
- (void)didTriggerShareButtonTapEvent;

@end

