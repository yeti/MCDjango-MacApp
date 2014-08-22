//
//  DirectoryInstallationView.m
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "DirectoryInstallationView.h"

@class SSHGeneratorController;

@implementation DirectoryInstallationView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*) parent
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.parent = parent;
        self.user = parent.user;
        self.githubUrl = [NSURL URLWithString:@"https://github.com/settings/ssh"];
    }
    return self;
}

- (void) loadView {
    [super loadView];
    self.githubImage = [[NSImage alloc] initByReferencingFile:@"static/images/github.png"];
    [self.githubButton setImage:self.githubImage];
    [self.manticoreLocation setURL:[[NSURL alloc] initFileURLWithPath:self.user.workspaceDir]];
    [self.parent.nextBtn setTitle:@"Create project!"];

}

- (void) nextAction {
    [self.projectTypeWindow setIsVisible:YES];
}

- (void) prevAction {
    [self.parent prevAction];
}

- (IBAction)checkForHomebrew:(id)sender {
    BOOL (^checkForBrew)() = ^ BOOL () {
        return [SystemInterface runCommand:@"/usr/bin/which /usr/local/bin/brew"].length;
 
    };
    
    [self checkForProgramOrInstall:@"brew"
                checkIfInstalled:checkForBrew
                needsToBeInstalled:&self->_installHomebrew
                             label:self.homebrewPresence
                            button:self.homeBrewButton
                    installCommand:@"/usr/bin/ruby -e \"$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\""];
}

- (IBAction)checkForPythonRequirements:(id)sender {
    BOOL (^checkForPythonRequirements)() = ^ BOOL() {
        NSString* command = @"try:\n\timport fabric\n\timport simplejson\n\tprint 1\nexcept ImportError:\n\tpass";
        [command writeToFile:@"./tester.py" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSString* output = [SystemInterface runCommand:@"/usr/local/bin/python ./tester.py"];
        [[NSFileManager defaultManager] removeItemAtPath:@"./tester.py" error:nil];
        return output.length;
    };
    
    [self checkForProgramOrInstall:@"simplejson and fabric"
                  checkIfInstalled:checkForPythonRequirements
                needsToBeInstalled:&self->_installPythonRequirements
                             label:self.pythonRequirementsPresence
                            button:self.pythonRequirementsButton
                    installCommand:@"/usr/local/bin/pip install simplejson fabric"];

}

- (IBAction)checkForPython:(id)sender {
    [self checkForProgramOrInstall:@"Python"
                  checkIfInstalled:^{return [SystemInterface checkIfInstalled:@"python"];}
                needsToBeInstalled:&self->_installPython
                             label:self.pythonPresence
                            button:self.pythonButton
                    installCommand:@"/usr/local/bin/brew install python"];

}

- (void) checkForProgramOrInstall:programName
                 checkIfInstalled:(BOOL(^)())isInstalled
               needsToBeInstalled:(BOOL*)install
                            label:(NSTextField*)statusBar
                           button:(NSButton*)button
                   installCommand:(NSString*)installCmd
{
    if (*install){
        [SystemInterface runCommandInTerminal:installCmd];
        *install = NO;
    }
    else {

        if (isInstalled()) {
            [statusBar setStringValue:[NSString stringWithFormat:@"You already have %@ successfully installed!", programName]];
            [statusBar setTextColor:[NSColor greenColor]];
            *install = NO;
        }
        else {
            [statusBar setStringValue:[NSString stringWithFormat:@"You need to install %@. Press the button to begin install.", programName]];
            [statusBar setTextColor:[NSColor redColor]];
            [button setTitle:[NSString stringWithFormat:@"Install %@",programName]];
            *install = YES;
        }
    }
}

- (IBAction)getManticoreDirectory:(id)sender {
    self.openPanel = [NSOpenPanel openPanel];
    [self.openPanel setCanChooseDirectories:YES];
    [self.openPanel setCanChooseFiles:NO];
    [self.openPanel setAllowsMultipleSelection:NO];
    if([self.openPanel runModal]) {
        NSURL* url = [self.openPanel.URLs objectAtIndex:0];
        self.user.workspaceDir = [url path];
        [self.manticoreLocation setURL:url];
        
    }
}

- (IBAction)getSSHKey:(id)sender {
    NSString* output = [SystemInterface getSSHKey:self.parent.user.homeDir fileName:@"tester.pub"];
    if ([output length]) {
        [self setSSHKeyFieldValue:output];
    }
    else {
        if (!self.sshGen) {
            self.sshGen = [[SSHGeneratorController alloc]initWithWindowNibName:@"SSHGenerator" parent:self];
        }
        [self.sshGen showWindow:self];
    }
}

- (void) setSSHKeyFieldValue:(NSString*)sshKey {
    [self.sshKeyField setStringValue:sshKey];
}

- (IBAction)openGithubSSHPage:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.githubUrl];
}

- (IBAction)existingProject:(id)sender {
    [self projectWizard:YES];
    }

- (IBAction)newProject:(id)sender {
    [self projectWizard:NO];
}

-(void) projectWizard:(BOOL)existingProject {
    NSString* fabCommand;
    if (!existingProject) {
        if (![self hasAppNameBeenSet] || ![self hasDbPassBeenSet]) {
            return;
        }
    }
    if ([self hasProjectNameBeenSet] && [self hasRepoNameBeenSet]) {
        [self.projectTypeWindow close];
        [self cloneManticore];
        [self createDirectories];
        [self haltVMs];
        if (existingProject) {
                 fabCommand =[NSString stringWithFormat:@"/usr/local/bin/fab -D -f %@/manticore-django/manticore_django/fabfile vagrant.clone:git@github.com:%@.git", self.user.workspaceDir, self.user.repoName];
        }
        else {
            fabCommand = [NSString stringWithFormat:@"/usr/local/bin/fab -D -f %@/manticore-django/manticore_django/fabfile vagrant.new:%@,%@,%@,git@github.com:%@.git", self.user.workspaceDir, self.user.projectName, self.user.appName, self.user.dbPass, self.user.repoName];
        }
        [self runFab:fabCommand];
    }

}

- (BOOL) hasProjectNameBeenSet {
    self.user.projectName = self.projectNameField.stringValue;
    self.user.projectDir = [NSString stringWithFormat:@"%@/%@", self.user.workspaceDir, self.user.projectName];
    return self.user.projectName.length;
}

- (BOOL) hasRepoNameBeenSet {
    self.user.repoName = self.projectRepoField.stringValue;
    return self.user.repoName.length;
}

- (BOOL) hasAppNameBeenSet {
    self.user.appName = self.projectAppNameField.stringValue;
    return self.user.appName.length;
}

- (BOOL) hasDbPassBeenSet {
    self.user.dbPass = self.projectDbPassField.stringValue;
    return self.user.dbPass.length;
}

- (void) cloneManticore {
    NSLog(@"in clone manticore");
    NSString* cloneCommand = [NSString stringWithFormat:@"/usr/bin/git clone git@github.com:YetiHQ/manticore-django.git %@/manticore-django", self.user.workspaceDir];
    NSLog(@"running command");
    [SystemInterface runCommand:cloneCommand];
}

-(BOOL) createDirectories {
    BOOL isDir;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.user.projectDir isDirectory:&isDir]) {
        if (![fileManager createDirectoryAtPath:self.user.projectDir withIntermediateDirectories:YES attributes:nil error:NULL]) {
            NSString* errorMsg = [NSString stringWithFormat:@"I'm sorry. An unexpected error has occured during directory creation. Please ensure that you have write privileges in the specified project directory:\n%@", self.user.projectDir];
            [self.parent setError:errorMsg];
            return NO;
        }
    }
    else {
        NSString* errorMsg = [NSString stringWithFormat:@"The directory %@ already exists. Please try again with a different project name", self.user.projectDir];
        [self.parent setError:errorMsg];
        return NO;
    }
    return YES;
}

- (void) haltVMs {
    NSString* runningVMs = [SystemInterface runCommand:@"/usr/bin/VBoxManage list runningvms"];
    if (runningVMs.length) {
        NSMutableString* shutdown = [[NSMutableString alloc] initWithString:@"/usr/bin/vagrant halt"];
        NSRegularExpression* idMatch = [[NSRegularExpression alloc] initWithPattern:@"^[0-9a-f]{6}.*running" options:0 error:nil];
        NSString* vms = [SystemInterface runCommand:@"/usr/bin/vagrant global-status"];
        NSArray* lines = [vms componentsSeparatedByString:@"\n"];
        
        for (NSString* line in lines) {
            if (line.length > 6 && [idMatch firstMatchInString:line options:0 range:NSMakeRange(0,6)]) {
                NSLog(@"match: %@", line);
                [shutdown appendString:[NSString stringWithFormat:@" %@",[line substringToIndex:6]]];
            }
        }
        [SystemInterface runCommandInTerminal:shutdown];
    }
}

- (void) runFab:(NSString *)fabCommand {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:self.user.projectDir];
    [SystemInterface runCommandInTerminal:fabCommand];
}

@end
