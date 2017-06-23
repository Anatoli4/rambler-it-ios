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

#import "SpeakerInfoRouter.h"

#import "LectureModuleInput.h"
#import "SafariFactory.h"
#import "MailComposeControllerFactory.h"
#import "SpeakerInfoAlertFactory.h"

#import <MessageUI/MessageUI.h>

static NSString *const kSpeakerModuleToLectureModuleSegue = @"SpeakerModuleToLectureModuleSegue";

@implementation SpeakerInfoRouter

#pragma mark - SpeakerInfoRouterInput

- (void)openWebBrowserModuleWithUrl:(NSURL *)url {
    UIViewController *safariViewController = [self.safariFactory createSafariViewControllerWithUrl:url];
    [(id)self.transitionHandler presentViewController:safariViewController
                                             animated:YES
                                           completion:nil];
}

- (void)openMailComposerModuleWithEmail:(NSString *)email {
    UIViewController *mailComposeController = [self.mailComposeFactory obtainMailComposeViewControllerForRecepientEmail:email];
    [[(id)self.transitionHandler navigationController] presentViewController:mailComposeController animated:true completion:nil];
}

- (void)openLectureModuleWithLectureId:(NSString *)lectureId {
    [[self.transitionHandler openModuleUsingSegue:kSpeakerModuleToLectureModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<LectureModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithLectureObjectId:lectureId];
        return nil;
    }];
}

- (void)openShareModuleWithActivityItems:(NSArray *)activityItems {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [[(id)self.transitionHandler navigationController] presentViewController:activityViewController animated:true completion:nil];
}

- (void)openEmailComposerUnavailableAlertModule {
    UIAlertController *alertController = [self.alertFactory createAlertControllerForUnavailableEmailComposer];
    [[(id)self.transitionHandler navigationController] presentViewController:alertController animated:true completion:nil];
}

- (void)openEmptyEmailAlertModule {
    UIAlertController *alertController = [self.alertFactory createAlertControllerForMissingEmail];
    [[(id)self.transitionHandler navigationController] presentViewController:alertController animated:true completion:nil];
}

@end
