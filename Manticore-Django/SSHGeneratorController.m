//
//  SSHGeneratorController.m
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "SSHGeneratorController.h"


@implementation SSHGeneratorController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(id) initWithWindowNibName:(NSString *)windowNibName parent:(InstallationController*)parent {
    self.parent = parent;
    self.user = parent.user;
    return [super initWithWindowNibName:windowNibName];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)createSSHKey:(id)sender {
    NSString *usersEmail = [self.email stringValue];
    NSString *usersPassphrase = [self.passphrase stringValue];
    NSString *usersPassphraseCheck = [self.passphraseCheck stringValue];
    NSString *outputDir = self.user.homeDir;
    NSString *outputFile = [NSString stringWithFormat:@"%@/.ssh/id_rsa", outputDir];
    
    if ([usersEmail length] && [usersPassphrase length] && [usersPassphraseCheck length]) {
        if ([usersPassphrase isEqual:usersPassphraseCheck]) {
            NSString *sshKeyGen = [NSString stringWithFormat:@"/usr/bin/ssh-keygen -t rsa -b 4096 -C %@ -N %@ -f %@",
                                   usersEmail, usersPassphrase, outputFile];
            [SystemInterface runCommand:sshKeyGen];
            [self.parent setSSHKeyFieldValue: [SystemInterface getSSHKey:outputDir fileName:@"id_rsa.pub"]];
        }
        else {
            [self.errorMessage setStringValue:@"Your passwords don't match. Please try again."];
            return;
        }
    }
    else {
        [self.errorMessage setStringValue:@"All fields must be filled out to generate your SSH key"];
        return;
    }
}
@end
