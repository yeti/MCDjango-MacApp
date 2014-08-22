//
//  StatusBoxController.m
//  Manticore-Django
//
//  Created by James on 8/14/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "StatusBoxController.h"

@implementation StatusBoxController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    NSLog(@"I should only get called once");
    [super windowDidLoad];
    NSSize scrollViewSize = [self.outputBox contentSize];

    [self.outputBox setHasVerticalScroller:YES];
    [self.outputBox setAutoresizingMask:NSViewWidthSizable |
     NSViewHeightSizable];
    
    self.outputText = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, scrollViewSize.width, scrollViewSize.height)];
    [self.outputText setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [self.outputText.textContainer setContainerSize:NSMakeSize(scrollViewSize.width, FLT_MAX)];
    [self.outputText setVerticallyResizable:YES];
    [self.outputText setHorizontallyResizable:NO];
    [self.outputText setAutoresizingMask:NSViewWidthSizable];
    
    [[self.outputText textContainer] setWidthTracksTextView:YES];
    
    [self.outputBox setDocumentView:self.outputText];
}

- (IBAction)close:(id)sender {
    [self close];
}

- (void) setStringValue:(NSString *)value {
//    NSString *myCopy = [NSString stringWithString:value];
    if (!self.counter) {
        self.counter = 1;
    } else {
        NSLog(@"value is %li", (long) self.counter++);
    }
    NSLog(@"string is %@", self.outputText.string);
//    [self.outputText setString:[NSString stringWithString: value]];
//        NSLog(@"myCopy: %@ \n\n", [value substringWithRange:NSMakeRange(0,30)]);
//        if (self.outputText.textStorage.string.length > 30) {
//            NSLog(@"textStorage: %@ \n\n", [self.outputText.textStorage.string substringWithRange:NSMakeRange(0,30)]);
//        }
//        NSLog(@"starting append");
        [self.outputText.textStorage appendAttributedString:[[NSAttributedString alloc] initWithString:value]];
//        NSLog(@"append step 2");
//        NSLog(@"outText %@", self.outputText);
//        self.currentTextView = NSMakeRange(self.outputText.string.length, 0);
//        NSLog(@"location is %li and length is %li", (long) self.currentTextView.location-10, (long) self.currentTextView.length);
//        @try {
//            [self.outputText scrollRangeToVisible:NSMakeRange(self.outputText.string.length, 0)];
//        }
//        @catch (NSException* e){
//            NSLog(@"caught exception %@", e);
//        }
    
    
//    BOOL scroll = (NSMaxY(self.outputText.visibleRect) != NSMaxY(self.outputText.bounds));
//    if (scroll) {

//    }
    NSLog(@"done appending");
}
@end
