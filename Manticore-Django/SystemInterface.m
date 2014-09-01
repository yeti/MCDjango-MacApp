//
//  SystemInterface.m
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "SystemInterface.h"

@implementation SystemInterface

+ (NSString*) runTask: (NSTask*)task waitUntilFinished:(BOOL)wait {
    NSPipe* output = [NSPipe pipe];

    task.standardOutput = output;
    NSFileHandle* outputFile = output.fileHandleForReading;
    [task launch];
    if (wait) {
        while ([task isRunning]);
    }
    return [[NSString alloc] initWithData:
            [outputFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

+ (NSTask*) prepareTaskForCommand:(NSString*)command {
    NSLog(@"command is %@", command);
    NSTask* task = [[NSTask alloc] init];
    NSRange firstSpace = [command rangeOfString:@" "];
    if (firstSpace.location != NSNotFound) {
        NSString *cmdString = [command substringToIndex:firstSpace.location];
        NSString *argString = [command substringFromIndex:firstSpace.location+1];
        NSArray *args = [argString componentsSeparatedByString:@" "];
        
        task.launchPath = cmdString;
        task.arguments = args;
    }
    else {
        task.launchPath = command;
    }
    return task;
}

+ (NSString*) runCommand: (NSString*)command {
    return [SystemInterface runTask:[SystemInterface prepareTaskForCommand:command] waitUntilFinished:YES];
}

+ (void) runCommandInTerminal: (NSString*) command {
    NSString* appleCommand = [NSString stringWithFormat:@"tell application \"Terminal\"\n\tactivate\n\tdo script\"%@; exit\"\nend tell", command];
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:appleCommand];
    [appleScript executeAndReturnError:nil];
}


+ (BOOL) checkIfInstalled: (NSString*)program {
    NSString *which =[NSString stringWithFormat: @"/usr/bin/which %@", program];
    NSString *output = [SystemInterface runCommand:which];
    NSLog(@"output string is %@", output);
    return [output length] ? YES : NO;
}

+ (NSString*) getSSHKey: (NSString*) homeDirectory fileName:(NSString*)file{
    NSString* sshKeyFile;
    if (file) {
        sshKeyFile = [NSString stringWithFormat:@"%@/.ssh/%@", homeDirectory, file];
    }
    else {
        sshKeyFile = [NSString stringWithFormat:@"%@/.ssh/id_rsa.pub", homeDirectory];
    }
    return [SystemInterface runCommand:[NSString stringWithFormat: @"/bin/cat %@", sshKeyFile]];
}

@end
