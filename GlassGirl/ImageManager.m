//
//  ImageManager.m
//  GlassGirl
//
//  Created by HalloWorld on 14-7-4.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

+ (instancetype)shareManager
{
    static ImageManager *manager = nil;
    if (manager == nil) {
        manager = [[ImageManager alloc] init];
    }
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dscDir = [self resourceRootDir];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dscDir]) {
            NSString *dir = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"MyImg"];
            NSError *err = nil;
            [[NSFileManager defaultManager] copyItemAtPath:dir toPath:[self resourceRootDir] error:&err];
            if (err) {
                NSLog(@"%s -> %@", __FUNCTION__, err);
            }
        }
    }
    return self;
}

- (NSString *)resourceRootDir
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dir = [document stringByAppendingPathComponent:@"MyImg"];
    return dir;
}


- (NSArray *)resourceImages
{
    NSString *rootDir = [self resourceRootDir];
    NSArray *subItems = [[NSFileManager defaultManager] subpathsAtPath:rootDir];
    return subItems;
}

- (UIImage *)imageOfName:(NSString *)imgName
{
    NSString *path = [[self resourceRootDir] stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:path];
}

@end
