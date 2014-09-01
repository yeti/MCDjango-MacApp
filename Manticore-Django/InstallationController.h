//
//  DirectoryInstallationView.h
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSHGeneratorController.h"
#import "AppController.h"
#import "SSHGeneratorController.h"
#import "SystemInterface.h"
#import "UserModel.h"
#import "ViewFlow.h"

@class SSHGeneratorController;
@class AppController;

@interface InstallationController : NSViewController <ViewFlow>

@property (weak) AppController* parent;
@property (weak) UserModel* user;
@property (strong) SSHGeneratorController* sshGen;

@property (assign) IBOutlet NSWindow* window;
@property (strong) NSOpenPanel* openPanel;
@property (assign) BOOL directorySelectWasSuccessful;

@property (weak) IBOutlet NSTextField* sshKeyField;

@property (weak) IBOutlet NSButton* homeBrewButton;
@property (weak) IBOutlet NSTextField* homebrewPresence;
@property (assign) BOOL installHomebrew;

@property (weak) IBOutlet NSButton* pythonButton;
@property (weak) IBOutlet NSTextField* pythonPresence;
@property (assign) BOOL installPython;

@property (weak) IBOutlet NSPathCell *manticoreLocation;

@property (weak) IBOutlet NSButton* pythonRequirementsButton;
@property (weak) IBOutlet NSTextField* pythonRequirementsPresence;
@property (assign) BOOL installPythonRequirements;

@property (weak) IBOutlet NSButton* githubButton;
@property (strong) NSImage* githubImage;
@property (strong) NSURL* githubUrl;

@property (strong) IBOutlet NSWindow *projectTypeWindow;
@property (weak) IBOutlet NSTextField *projectNameField;
@property (weak) IBOutlet NSTextField *projectRepoField;
@property (weak) IBOutlet NSTextField *projectAppNameField;
@property (weak) IBOutlet NSTextField *projectDbPassField;

@property (assign) BOOL projectIsSetup;

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*) parent;


- (void) loadView;

- (IBAction)checkForPython:(id)sender;
- (IBAction)checkForHomebrew:(id)sender;
- (IBAction)checkForPythonRequirements:(id)sender;

- (void) checkForProgramOrInstall:programName
                 checkIfInstalled:(BOOL(^)())isInstalled
               needsToBeInstalled:(BOOL*)install
                            label:(NSTextField*)statusBar
                           button:(NSButton*)button
                   installCommand:(NSString*)installCmd;


- (IBAction)getManticoreDirectory:(id)sender;
- (IBAction)getSSHKey:(id)sender;
- (void) setSSHKeyFieldValue:(NSString*)sshKey;
- (IBAction)openGithubSSHPage:(id)sender;

- (IBAction)existingProject:(id)sender;
- (IBAction)newProject:(id)sender;
- (void) projectWizard:(BOOL)existingProject;

- (void) cloneManticore;
- (BOOL) createDirectories;
- (void) haltVMs;
- (void) runFab:(NSString*)fabCommand;

- (BOOL) hasProjectNameBeenSet;
- (BOOL) hasRepoNameBeenSet;
- (BOOL) hasAppNameBeenSet;
- (BOOL) hasDbPassBeenSet;

- (void) setProjectIsSetupToTrue;

@end
