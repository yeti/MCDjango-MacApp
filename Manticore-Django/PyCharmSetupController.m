//
//  PyCharmSetupController.m
//  Manticore-Django
//
//  Created by James on 8/27/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "PyCharmSetupController.h"

@interface PyCharmSetupController ()

@end

@implementation PyCharmSetupController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*)parent
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.parent = parent;
    }
    return self;
}

- (void) loadView {
    [super loadView];
    self.pycharmImage = [[NSImage alloc] initByReferencingFile:@"static/images/pycharm-logo.png"];
    [self.pycharmButton setImage:self.pycharmImage];
}

- (IBAction)launchPycharm:(id)sender {
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/PyCharm.app"];
}
@end
