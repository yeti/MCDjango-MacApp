//
//  AppController.h
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "InstallationController.h"
#import "RequiredDownloadsController.h"
#import "PyCharmSetupController.h"
#import "ViewFlow.h"
#define VIEW_COUNT 2

@interface AppController : NSObject <ViewFlow>

@property (strong) UserModel* user;

@property (assign) NSInteger currentView;
@property (weak) IBOutlet NSView* mainView;
@property (strong) NSViewController* mainViewController;
@property (weak) IBOutlet NSButton* nextBtn;
@property (weak) IBOutlet NSWindow* errorWindow;
@property (weak) IBOutlet NSTextField* errorMessage;

@property (weak) IBOutlet NSButtonCell* manticoreLogo;
@property (weak) IBOutlet NSTextFieldCell *manticore;


- (IBAction)nextView:(id)sender;
- (IBAction)prevView:(id)sender;
- (IBAction)cancel:(id)sender;
- (void) changeViewController:(NSInteger)number;


- (IBAction)closeErrorWindow:(id)sender;
- (void) setError:(NSString*)errorMessage;
@end
