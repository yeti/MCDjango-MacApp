//
//  SSHGeneratorController.h
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InstallationController.h"
#import "SystemInterface.h"
#import "UserModel.h"

@class InstallationController;

@interface SSHGeneratorController : NSWindowController
@property (weak) InstallationController* parent;
@property (weak) UserModel* user;

@property (weak) IBOutlet NSTextField* email;
@property (weak) IBOutlet NSSecureTextFieldCell* passphrase;
@property (weak) IBOutlet NSSecureTextField* passphraseCheck;
@property (weak) IBOutlet NSTextField* errorMessage;

- (id) initWithWindowNibName:(NSString*)windowNibName parent:(InstallationController*)parent;

- (IBAction)createSSHKey:(id)sender;
@end
