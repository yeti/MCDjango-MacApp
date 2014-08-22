//
//  AppController.m
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "AppController.h"

@implementation AppController

enum {
    kDownloadsView = 0,
    kDirectoryView
};

NSString *const kDirectoryViewNib = @"DirectoryInstallationView";
NSString *const kDownloadViewNib = @"RequiredDownloadsView";

- (void) awakeFromNib {
    self.user = [[UserModel alloc] init];
    [self changeViewController:kDownloadsView];
    [self.manticoreLogo setImage:[[NSImage alloc] initByReferencingFile:@"static/images/logo_manticore.png"]];
    [self.manticore setImage:[[NSImage alloc] initByReferencingFile:@"static/images/logo_manticore.png"]];
    
}


- (IBAction)nextView:(id)sender {
    if ([self.mainViewController conformsToProtocol:@protocol(ViewFlow)]) {
        id <ViewFlow> mainViewCont = self.mainViewController;
        [mainViewCont nextAction];
    }
    else {
     [self nextAction];
    }
}

- (IBAction)prevView:(id)sender {
    if ([self.mainViewController conformsToProtocol:@protocol(ViewFlow)]) {
        id <ViewFlow> mainViewCont = self.mainViewController;
        [mainViewCont prevAction];
    }
    else {
        [self prevAction];
    }
}

-(void) nextAction {
    if (self.currentView < VIEW_COUNT) {
        [self changeViewController:++self.currentView];
    }
    else {
        [NSApp terminate:self];
    }
}

- (void) prevAction {
    if (self.currentView > 0) {
        if ([self.nextBtn.title isEqual:@"Finish"]) {
            self.nextBtn.title = @"Next";
        }
        [self changeViewController:--self.currentView];
    }

}

- (IBAction)cancel:(id)sender {
    [NSApp terminate:self];
}

-(void) changeViewController:(NSInteger)number {
    [self.mainViewController.view removeFromSuperview];
    switch (number) {
        case kDirectoryView:
            self.mainViewController = [[DirectoryInstallationView alloc] initWithNibName:kDirectoryViewNib bundle:nil parent:self];
            break;
        case kDownloadsView:
            self.mainViewController = [[RequiredDownloadsView alloc] initWithNibName:kDownloadViewNib bundle:nil parent:self];
        default:
            break;
    }
    [self.mainView addSubview:self.mainViewController.view];
}

- (IBAction)closeErrorWindow:(id)sender {
    [self.errorWindow close];
}

- (void)setError:(NSString *)errorMessage {
    [self.errorMessage setStringValue:errorMessage];
    [self.errorWindow setIsVisible:YES];
}


@end
