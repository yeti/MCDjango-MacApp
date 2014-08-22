//
//  SystemInterface.h
//  Manticore-Django
//
//  Created by James on 8/13/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInterface : NSObject

+ (NSString*) runCommand:(NSString*)command;
//+ (NSString*) runPythonCommand: (NSString*)command;
+ (void) runCommandInTerminal:(NSString*)command;
+ (BOOL) checkIfInstalled:(NSString*)program;
+ (NSString*) getSSHKey:(NSString*)homeDirectory fileName:(NSString*)file;



+ (NSString*) runTask:(NSTask*)task waitUntilFinished:(BOOL)wait frameToWriteStatusTo:(id)statusBox;

//+ (NSTask*) prepareTaskForPythonCommand:(NSString*)command;
+ (NSTask*) prepareTaskForCommand:(NSString*)command;
@end
