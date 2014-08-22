//
//  RequiredDownloadsView.m
//  Manticore-Django
//
//  Created by James on 8/12/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "RequiredDownloadsView.h"

@interface RequiredDownloadsView ()

@end

@implementation RequiredDownloadsView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parent:(AppController*)parent
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.parent = parent;
    }

    return self;
}

- (void) initURLs {
    self.githubUrl = [NSURL URLWithString:@"https://github.com/"];

    self.pycharmUrl = [NSURL URLWithString:@"http://download.jetbrains.com/python/pycharm-professional-3.4.1.dmg"];
    
    self.vagrantUrl = [NSURL URLWithString:@"https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3.dmg"];
    
    self.virtualBoxUrl = [NSURL URLWithString:@"http://download.virtualbox.org/virtualbox/4.3.14/VirtualBox-4.3.14-95030-OSX.dmg"];
    
    self.xcodeUrl = [NSURL URLWithString:@"macappstore://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12"];
}

- (void) initImages {
    self.githubImage = [[NSImage alloc] initByReferencingFile:@"static/images/github.png"];
    self.pycharmImage = [[NSImage alloc] initByReferencingFile:@"static/images/pycharm-logo.png"];
    self.vagrantImage = [[NSImage alloc] initByReferencingFile:@"static/images/Vagrant.png"];
    self.virtualBoxImage = [[NSImage alloc] initByReferencingFile:@"static/images/virtualbox-logo.png"];
    self.xcodeImage = [[NSImage alloc] initByReferencingFile:@"static/images/xcode_icon.png"];
}

- (void) initButtons {
    [self.githubButton setImage: self.githubImage];
    [self.pycharmButton setImage: self.pycharmImage];
    [self.vagrantButton setImage: self.vagrantImage];
    [self.virtualBoxButton setImage: self.virtualBoxImage];
    [self.xcodeButton setImage: self.xcodeImage];
}

- (void) loadView {
    [super loadView];
    [self initImages];
    [self initURLs];
    [self initButtons];
    [self.parent.nextBtn setTitle:@"Next"];
}

- (void) nextAction {
    
}



- (IBAction)Vagrant:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.vagrantUrl];
}

- (IBAction)github:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.githubUrl];
}

- (IBAction)virtualBox:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.virtualBoxUrl];
}

- (IBAction)pycharm:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.pycharmUrl];
}

- (IBAction)xcode:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.xcodeUrl];
}
@end
