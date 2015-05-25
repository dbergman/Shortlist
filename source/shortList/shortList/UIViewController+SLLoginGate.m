//
//  UIViewController+SLLoginGate.m
//  shortList
//
//  Created by Dustin Bergman on 5/13/15.
//  Copyright (c) 2015 Dustin Bergman. All rights reserved.
//

#import "UIViewController+SLLoginGate.h"
#import "SLLoginVC.h"
#import "SLUserSignUpVC.h"
#import <Parse/Parse.h>

@implementation UIViewController (SLLoginGate)

- (void)showLoginGateWithCompletion:(dispatch_block_t)completion {
    if (![PFUser currentUser]) {
        SLLoginVC *loginVC = [[SLLoginVC alloc] init];
        loginVC.facebookPermissions = @[@"friends_about_me"];
        loginVC.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;

        SLUserSignUpVC *userSignUpVC = [[SLUserSignUpVC alloc] init];
        userSignUpVC.fields = PFSignUpFieldsDefault;
        loginVC.signUpController = userSignUpVC;

        [self presentViewController:loginVC animated:YES completion:NULL];
    }
    else {
        PFUser *user = [PFUser currentUser];
    }
    
    if (completion) {
        completion();
    }
}

@end
