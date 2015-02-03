
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

}

-(void) setupSignals {


    RACSignal *validUserSignal =

            [self.usernameTextField.rac_textSignal
                    map:^id(NSString *text) {
                        return @([self isValidUsername:text]);
                    }];

    RACSignal *validPasswordSignal =
            [self.passwordTextField.rac_textSignal
                    map:^id (NSString *text) {
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

}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

- (IBAction)signInButtonTouched:(id)sender {
    // disable all UI controls
    self.signInButton.enabled = NO;
    self.signInFailureText.hidden = YES;

    // sign in
    [self.signInService signInWithUsername:self.usernameTextField.text
                                  password:self.passwordTextField.text
                                  complete:^(BOOL success) {
                                      self.signInButton.enabled = YES;
                                      self.signInFailureText.hidden = success;
                                      if (success) {
                                          [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                                      }
                                  }];
}

@end
