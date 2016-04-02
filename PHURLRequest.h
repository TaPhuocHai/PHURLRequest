//
//  PHURLRequest.h
//  WebTreTho3.0
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface WTURLRequest : NSObject

+ (void)shareRequestWithUrl:(NSString*)url;

+ (AFHTTPRequestOperation*)getWithEndpoint:(NSString*)endpoint
                                parameters:(NSDictionary *)parameters
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;

+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;


+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;

+ (AFHTTPRequestOperation*)postWithEndpoint:(NSString*)endpoint
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   progress:(void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                                    success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                    failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;

+ (AFHTTPRequestOperation*)putWithEndpoint:(NSString*)endpoint
                                parameters:(NSDictionary *)parameters
                 constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;


#pragma - mark

+ (AFHTTPRequestOperation*)downloadWithUrl:(NSString*)urlStr
                                    toFile:(NSURL*)fileUrl
                                  progress:(void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                                   success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success
                                   failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;

@end
