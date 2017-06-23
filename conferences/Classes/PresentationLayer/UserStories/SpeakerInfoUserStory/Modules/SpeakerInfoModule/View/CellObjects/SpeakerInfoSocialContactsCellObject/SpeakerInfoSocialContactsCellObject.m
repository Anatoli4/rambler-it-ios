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

#import "SpeakerInfoSocialContactsCellObject.h"
#import "SocialNetworkAccountPlainObject.h"
#import "SpeakerInfoSocialContactsTableViewCell.h"

@interface SpeakerInfoSocialContactsCellObject ()

@property (nonatomic, assign, readwrite) NSString *image;
@property (nonatomic, strong, readwrite) NSString *link;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) SocialNetworkType networkType;

@end

@implementation SpeakerInfoSocialContactsCellObject

- (instancetype)initWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                       image:(NSString *)image
                                        text:(NSString *)text {
    self = [super init];
    if (self) {
        _image = image;
        _link = account.profileLink;
        _name = text;
        _networkType = [account.type integerValue];
    }
    
    return self;
}

+ (instancetype)objectWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                         image:(NSString *)image
                                          text:(NSString *)text {
    return [[self alloc] initWithSocialNetworkAccount:account
                                                image:image
                                                 text:text];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [SpeakerInfoSocialContactsTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerInfoSocialContactsTableViewCell class])
                          bundle:[NSBundle mainBundle]];
}

@end
