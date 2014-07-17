//
//  ImageManager.m
//  GlassGirl
//
//  Created by HalloWorld on 14-7-4.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "ImageManager.h"
#import "UIImage+Glass.h"

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
            [self initGlassImage];
        }
    }
    return self;
}

- (void)initGlassImage
{
    NSString *imgDir = [self resourceRootDir];
    NSString *glassDir = [self glassRootDir];
    //创建glass folder
    NSError *err = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:glassDir withIntermediateDirectories:YES attributes:nil error:&err];
    if (err) {
        NSLog(@"%s -> %@", __FUNCTION__, err);
    }
    
    NSArray *srcImgPaths = [self resourceImages];
    for (NSString *item in srcImgPaths) {
        NSString *srcItem = [imgDir stringByAppendingPathComponent:item];
        UIImage *srcImg = [UIImage imageWithContentsOfFile:srcItem];
        UIImage *glassImg = [srcImg glassImage];
        NSData *data = UIImageJPEGRepresentation(glassImg, 1.0);
        NSString *dscPath = [glassDir stringByAppendingPathComponent:item];
        [data writeToFile:dscPath atomically:YES];
    }
}

- (NSString *)glassRootDir
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dir = [document stringByAppendingPathComponent:@"Glass"];
    return dir;
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

- (UIImage *)glassImageOfName:(NSString *)imgName
{
    NSString *path = [[self glassRootDir] stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:path];
}

- (void)saveNewImage:(UIImage *)origImg
{
    NSString *namePrefix = [ImageManager uuidString];
    NSString *name = [namePrefix stringByAppendingString:@".png"];
    
    NSString *origPath = [[self resourceRootDir] stringByAppendingPathComponent:name];
    [UIImagePNGRepresentation(origImg) writeToFile:origPath atomically:YES];
    
    UIImage *img = [UIImage imageWithContentsOfFile:origPath];
    UIImage *glassImg = [img glassImage];
    NSString *glassPath = [[self glassRootDir] stringByAppendingPathComponent:name];
    [UIImagePNGRepresentation(glassImg) writeToFile:glassPath atomically:YES];
}


+ (NSString *)uuidString
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

- (void)removeItem:(NSString *)itemName
{
    NSString *oriPath = [[self resourceRootDir] stringByAppendingPathComponent:itemName];
    NSError *err = nil;
    [[NSFileManager defaultManager] removeItemAtPath:oriPath error:&err];
    if (err) {
        NSLog(@"%s -> %@", __FUNCTION__, err);
    }
    
    NSString *glsPath = [[self glassRootDir] stringByAppendingPathComponent:itemName];
    [[NSFileManager defaultManager] removeItemAtPath:glsPath error:&err];
    if (err) {
        NSLog(@"%s -> %@", __FUNCTION__, err);
    }
}

@end
