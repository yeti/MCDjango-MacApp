//
//  SystemInterface.m
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "SystemInterface.h"

@implementation SystemInterface

+ (NSString*) runTask: (NSTask*)task waitUntilFinished:(BOOL)wait frameToWriteStatusTo:(id)statusBox{
    NSPipe* output = [NSPipe pipe];
//    NSPipe* error = [NSPipe pipe];
    task.standardOutput = output;
//    task.standardError = error;
    NSFileHandle* outputFile = output.fileHandleForReading;
//    NSFileHandle* errorFile = error.fileHandleForReading;
    
//    if (statusBox) {
//        [outputFile setReadabilityHandler: ^(NSFileHandle *aFile) {
//            NSData* data = [aFile availableData];
//            NSString* read = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            [statusBox setStringValue:read];
//        }];
//        
//        [task setTerminationHandler:^(NSTask* aTask) {
//            outputFile.readabilityHandler = nil;
//        }];
//        [task launch];
//    }
//    else {
        [task launch];
        if (wait) {
            while ([task isRunning]);
        }
//        NSString* errorMessage = [[NSString alloc] initWithData:[errorFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
////        if (errorMessage.length) {
////            NSLog(@"error is being returned or length %li", (long) errorMessage.length);
////            
////            return errorMessage;
////        }
//        else {
            return [[NSString alloc] initWithData:[outputFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
//        }
//    }
//    return nil;
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

//+ (NSTask*) prepareTaskForPythonCommand:(NSString*)command {
//    NSTask* task = [[NSTask alloc] init];
//    NSRange firstSpace = [command rangeOfString:@" "];
//    NSRange commandString = [command rangeOfString:@"-c"];
//    BOOL commandIsCommandString = commandString.location != NSNotFound;
//    if (commandIsCommandString) {
//        NSString *cmdString = [command substringToIndex:firstSpace.location];
//        NSString *argString = [command substringFromIndex:commandString.location];
//        NSArray *args = @[argString];
//        NSLog(@"cmdString string is %@", cmdString);
//        NSLog(@"args are %@", args);
//        task.launchPath = cmdString;
//        task.arguments = args;
//    }
//    else {
//        task.launchPath = command;
//    }
//    return task;
//}


+ (NSString*) runCommand: (NSString*)command {
    return [SystemInterface runTask:[SystemInterface prepareTaskForCommand:command] waitUntilFinished:YES frameToWriteStatusTo:NULL];
}

//+ (NSString*) runPythonCommand: (NSString*)command {
//    return [SystemInterface runTask:[SystemInterface prepareTaskForPythonCommand:command] waitUntilFinished:YES frameToWriteStatusTo:NULL];
//}
//
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
