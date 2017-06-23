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

#import <Foundation/Foundation.h>

typedef void (^ActionAlertBlock)();

@protocol LectureRouterInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to initiate transition to the SpeakerInfo module
 
 @param objectId NSString object id
 */
- (void)openSpeakerInfoModuleWithSpeakerObjectId:(NSString *)objectId;

/**
 @author Artem Karpushin
 
 Method is used to initiate transition to the module of the event sharing
 
 @param activityItems Array of activity items for sharing
 */
- (void)openShareModuleWithActivityItems:(NSArray *)activityItems;

/**
 @author Egor Tolstoy
 
 Method is used to open web browser module
 
 @param url Opening url
 */
- (void)openWebBrowserModuleWithUrl:(NSURL *)url;

/**
 @author Egor Tolstoy
 
 Method opens YouTube player module
 
 @param identifier Video identifier
 */
- (void)openYouTubeVideoPlayerModuleWithIdentifier:(NSString *)identifier;

/**
 @author Konstantin Zinovyev
 
 Method opens AVPlayer with cache video
 
 @param path Video path
 */
- (void)openLocalVideoPlayerModuleWithPath:(NSString *)path;

/**
 @author Konstantin Zinovyev
 
 Method shows alert with removing message
 
 @param block Confirm block
 */
- (void)showAlertConfirmationRemoveWithActionBlock:(ActionAlertBlock)block;

/**
 @author Konstantin Zinovyev
 
 Method shows alert with dowloanloading message
 
 @param block Confirm block
 */
- (void)showAlertConfirmationDownloadWithActionBlock:(ActionAlertBlock)block;

/**
 @author Konstantin Zinovyev
 
 Method shows alert with error message
 
 @param message error message
 */
- (void)showAlertErrorWithMessage:(NSString *)message;

@end

