//
//  UserModel.m
//  Manticore-Django
//
//  Created by James on 8/14/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id) init {
    self = [super init];
    if (self) {
        self.homeDir = [NSString stringWithFormat:@"/Users/%@",NSUserName()];
        self.workspaceDir = [NSString stringWithFormat:@"%@/projects", self.homeDir];
        
    }
    return self;
}

@end
