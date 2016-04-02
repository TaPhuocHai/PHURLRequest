//
//  PHURLRequest.m
//  WebTreTho3.0
//
//  Created by Ta Phuoc Hai on 5/21/14.
//  Copyright (c) 2014 PH. All rights reserved.
//

#import "PHURLRequest.h"

@implementation WTURLRequest

static NSString * _shareUrl;
+ (void)shareRequestWithUrl:(NSString*)urlStr
{
    _shareUrl = urlStr;
}


+ (AFHTTPRequestOperation*)getWithEndpoint:(NSString*)endpoint
                                parameters:(NSDictionary *)parameters
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    AFHTTPRequestOperationManager *manager = [self requestOperationManager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager GET:endpoint
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    if(success) success(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    if(failure) failure(operation, error);
                }];
}

+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    AFHTTPRequestOperationManager *manager = [self requestOperationManager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager POST:endpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(success) success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(failure) failure(operation, error);
    }];
}

+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    AFHTTPRequestOperationManager *manager = [self requestOperationManager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager POST:endpoint parameters:parameters constructingBodyWithBlock:block
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                if(success) success(operation, responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                if(failure) failure(operation, error);
            }];
}


+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   progress:(void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    NSString * urlStr = [_shareUrl stringByAppendingString:endpoint];
    
    NSError * requestBuildError;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                               URLString:urlStr
                                                                                              parameters:parameters
                                                                               constructingBodyWithBlock:block
                                                                                                   error:&requestBuildError];
    if (requestBuildError) {
        if(failure) failure(nil, requestBuildError);
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) progress((NSUInteger)totalBytesWritten, (NSUInteger)totalBytesExpectedToWrite);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(success) success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (operation.response.statusCode == 201 || operation.response.statusCode == 200) {
            id response = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:nil];
            if(success) success(operation, response);
        } else {
            if(failure) failure(operation, error);
        }
    }];
    [operation start];
    
    return operation;
}

+ (AFHTTPRequestOperation*)putWithEndpoint:(NSString*)endpoint
                                parameters:(NSDictionary *)parameters
                 constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    NSString * urlStr = [_shareUrl stringByAppendingString:endpoint];
    
    NSError * requestBuildError;
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT"
                                                                                               URLString:urlStr
                                                                                              parameters:parameters
                                                                               constructingBodyWithBlock:block
                                                                                                   error:&requestBuildError];
    if (requestBuildError) {
        if(failure) failure(nil, requestBuildError);
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success) success(operation, responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (operation.response.statusCode == 201 || operation.response.statusCode == 200) {
            id response = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:nil];
            if(success) success(operation, response);
        } else {
            if(failure) failure(operation, error);
        }
    }];
    [operation start];
    
    return operation;
}


+ (AFHTTPRequestOperation*)putWithEndpoint:(NSString*)endpoint
                                parameters:(NSDictionary *)parameters
                                   staging:(BOOL)isStagingMode
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    AFHTTPRequestOperationManager *manager = [self requestOperationManager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager PUT:endpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(success) success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(failure) failure(operation, error);
    }];
}

+ (AFHTTPRequestOperation*)deleteWithEndpoint:(NSString*)endpoint
                                   parameters:(NSDictionary *)parameters
                                      staging:(BOOL)isStagingMode
                                      success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                      failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    AFHTTPRequestOperationManager *manager = [self requestOperationManager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager DELETE:endpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(success) success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(failure) failure(operation, error);
    }];
}

#pragma mark -

+ (AFHTTPRequestOperation*)downloadWithUrl:(NSString*)urlStr
                                    toFile:(NSURL*)fileUrl
                                  progress:(void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    operation.outputStream = [NSOutputStream outputStreamWithURL:fileUrl append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (progress) progress(totalBytesRead, totalBytesExpectedToRead);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(success) success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (operation.response.statusCode == 201 || operation.response.statusCode == 200) {
            if(success) success(operation, nil);
        } else {
            if(failure) failure(operation, error);
        }
    }];
    [operation start];
    return operation;
}

#pragma mark - Helper

+ (AFHTTPRequestOperationManager*)requestOperationManager
{
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:
                                               [NSURL URLWithString:_shareUrl]];
    return manager;
}

@end
