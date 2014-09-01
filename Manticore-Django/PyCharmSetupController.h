//
//  PyCharmSetupController.h
//  Manticore-Django
//
//  Created by James on 8/27/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppController.h"

@interface PyCharmSetupController : NSViewController
@property (weak) AppController* parent;
@property (strong) NSImage* pycharmImage;
@property (weak) IBOutlet NSButton* pycharmButton;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*)parent;
- (IBAction)launchPycharm:(id)sender;

@end
