//
//  SSHGeneratorController.h
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DirectoryInstallationView.h"
#import "SystemInterface.h"
#import "UserModel.h"

@class DirectoryInstallationView;

@interface SSHGeneratorController : NSWindowController
@property (weak) DirectoryInstallationView* parent;
@property (weak) UserModel* user;

@property (weak) IBOutlet NSTextField* email;
@property (weak) IBOutlet NSSecureTextFieldCell* passphrase;
@property (weak) IBOutlet NSSecureTextField* passphraseCheck;
@property (weak) IBOutlet NSTextField* errorMessage;

- (id) initWithWindowNibName:(NSString*)windowNibName parent:(DirectoryInstallationView*)parent;

- (IBAction)createSSHKey:(id)sender;
@end
