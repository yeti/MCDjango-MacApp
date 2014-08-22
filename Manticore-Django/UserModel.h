//
//  UserModel.h
//  Manticore-Django
//
//  Created by James on 8/14/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property NSString* homeDir;
@property NSString* workspaceDir;
@property NSString* projectDir;
@property NSString* repoName;
@property NSString* projectName;
@property NSString* appName;
@property NSString* dbPass;
@end
