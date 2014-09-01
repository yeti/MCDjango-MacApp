//
//  RequiredDownloadsView.h
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppController.h"

@class AppController;

@interface RequiredDownloadsController : NSViewController

@property (weak) AppController* parent;

@property (weak) IBOutlet NSButton* githubButton;
@property (strong) NSImage* githubImage;
@property (strong) NSURL* githubUrl;

@property (weak) IBOutlet NSButton* pycharmButton;
@property (strong) NSImage* pycharmImage;
@property (strong) NSURL* pycharmUrl;

@property (weak) IBOutlet NSButton* vagrantButton;
@property (strong) NSImage* vagrantImage;
@property (strong) NSURL* vagrantUrl;

@property (weak) IBOutlet NSButton* virtualBoxButton;
@property (strong) NSImage* virtualBoxImage;
@property (strong) NSURL* virtualBoxUrl;

@property (weak) IBOutlet NSButton* xcodeButton;
@property (strong) NSImage* xcodeImage;
@property (strong) NSURL* xcodeUrl;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*)parent;

- (void) loadView;
- (void) initButtons;
- (void) initImages;
- (void) initURLs;

- (IBAction)vagrant:(id)sender;
- (IBAction)github:(id)sender;
- (IBAction)virtualBox:(id)sender;
- (IBAction)pycharm:(id)sender;
- (IBAction)xcode:(id)sender;


@end
