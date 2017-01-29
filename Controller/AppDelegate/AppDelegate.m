//
//  AppDelegate.m
//  AppForAcromine
//
//  Created by Aditya Tanna on 4/11/16.
//  Copyright © 2016 Aditya Tanna. All rights reserved.

#import "AppDelegate.h"
#import "Constant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    return YES;
}

- (void)callWebService:(NSString*)url parameters:(NSDictionary*)params httpMethod:(NSString*)httpMethod complition:(void (^)(NSDictionary *response))completion failure:(void (^)(NSError *error, NSDictionary *response))failure
{
    if ([self isNetworkReachable]) {
        
       
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];;
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            [self hideActivity];
            
            
            id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
          
            completion([response lastObject]);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"error: %@",  error);
            
            failure(error,nil);
        }];
        
        
    }
}

#pragma mark Reachability

- (BOOL)isNetworkReachable {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];//[Reachability reachabilityWithHostName:@"http://www.google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable) {
        return NO;
    }
    return YES;
}

- (void)showActivityWithTitle:(NSString *)strTitle{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];

    hud.label.text = strTitle;
}

- (void)hideActivity{
    [MBProgressHUD hideHUDForView:self.window animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    
}
@end