//
//  StatusBoxController.h
//  Manticore-Django
//
//  Created by James on 8/14/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusBoxController : NSWindowController
@property (weak) IBOutlet NSScrollView *outputBox;
@property (strong) NSTextView *outputText;
@property (assign) NSInteger counter;
@property (assign) NSRange currentTextView;
@property (weak) IBOutlet NSTextFieldCell *command;

- (void) setStringValue: (NSString*)value;
- (IBAction)close:(id)sender;
@end
