//
//  AppDelegate.h
//  AppForAcromine
//
//  Created by Aditya Tanna on 4/11/16.
//  Copyright © 2016 Aditya Tanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showActivityWithTitle:(NSString *)strTitle;

- (void)hideActivity;

- (BOOL)isNetworkReachable;

- (void)callWebService:(NSString*)url parameters:(NSDictionary*)params httpMethod:(NSString*)httpMethod complition:(void (^)(NSDictionary *response))completion failure:(void (^)(NSError *error, NSDictionary *response))failure;

@end

