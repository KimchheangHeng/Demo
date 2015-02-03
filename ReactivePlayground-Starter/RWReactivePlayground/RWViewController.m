
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.signInService = [RWDummySignInService new];

    // handle text changes for both text fields

    // initially hide the failure message
    self.signInFailureText.hidden = YES;

    [self setupSignals];
}

-(void) setupSignals {


    RACSignal *validUserSignal =
            [self.usernameTextField.rac_textSignal
                    map:^id(NSString *text) {
                        return @([self isValidUsername:text]);
                    }];

    RACSignal *validPasswordSignal =
            [self.passwordTextField.rac_textSignal
                    map:^id(NSString *text) {
                        return @([self isValidPassword:text]);
                    }];

    RAC(self.usernameTextField, backgroundColor) =
            [validUserSignal
                    map:^UIColor *(NSNumber *validUserName) {
                        return [validUserName boolValue] ? [UIColor whiteColor] : [UIColor yellowColor];
                    }];

    RAC(self.passwordTextField, backgroundColor) =
            [validPasswordSignal
                    map:^UIColor *(NSNumber *validPassword) {

                        return [validPassword boolValue] ? [UIColor whiteColor] : [UIColor yellowColor];
                    }];

    RACSignal *signUpActiveSignal =
            [RACSignal
                    combineLatest:@[validUserSignal, validPasswordSignal]
                           reduce:^id(NSNumber *userNameValid, NSNumber *passwordValid) {

                               return @([userNameValid boolValue] && [passwordValid boolValue]);
                           }];

    [signUpActiveSignal subscribeNext:^(NSNumber *signUpValid) {
        self.signInButton.enabled = [signUpValid boolValue];
    }];

//    sign in button reactive
    [[[[self.signInButton
            rac_signalForControlEvents:UIControlEventTouchUpInside]
            doNext:^(id x) {
                self.signInButton.enabled = NO;
                self.signInFailureText.hidden = YES;
            }]
            flattenMap:^id(id value) {
                return [self signInSignal];
            }]
            subscribeNext:^(NSNumber *signIn) {
                NSLog(@"sign in result: %@", signIn);
                self.signInButton.enabled = YES;
                BOOL success = [signIn boolValue];
                self.signInFailureText.hidden = success;

                if (success) {
                    [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                }
            }];

}

- (RACSignal *)signInSignal {

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [self.signInService
                signInWithUsername:self.usernameTextField.text
                          password:self.passwordTextField.text
                          complete:^(BOOL success) {
                              [subscriber sendNext:@(success)];
                              [subscriber sendCompleted];
                          }];
        return nil;
    }];
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

@end
