//
//  SKPSMTPMessage.h
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>

enum
{
    kSKPSMTPIdle = 0,
    kSKPSMTPConnecting,
    kSKPSMTPWaitingEHLOReply,
    kSKPSMTPWaitingTLSReply,
    kSKPSMTPWaitingLOGINUsernameReply,
    kSKPSMTPWaitingLOGINPasswordReply,
    kSKPSMTPWaitingAuthSuccess,
    kSKPSMTPWaitingFromReply,
    kSKPSMTPWaitingToReply,
    kSKPSMTPWaitingForEnterMail,
    kSKPSMTPWaitingSendSuccess,
    kSKPSMTPWaitingQuitReply,
    kSKPSMTPMessageSent
};
typedef NSUInteger SKPSMTPState;

// Message part keys
extern NSString *kSKPSMTPPartContentDispositionKey;
extern NSString *kSKPSMTPPartContentTypeKey;
extern NSString *kSKPSMTPPartMessageKey;
extern NSString *kSKPSMTPPartContentTransferEncodingKey;

// Error message codes
#define kSKPSMPTErrorConnectionTimeout -5
#define kSKPSMTPErrorConnectionFailed -3
#define kSKPSMTPErrorConnectionInterrupted -4
#define kSKPSMTPErrorUnsupportedLogin -2
#define kSKPSMTPErrorTLSFail -1
#define kSKPSMTPErrorInvalidUserPass 535
#define kSKPSMTPErrorInvalidMessage 550
#define kSKPSMTPErrorNoRelay 530

@class SKPSMTPMessage;

@protocol SKPSMTPMessageDelegate
@required

-(void)messageSent:(SKPSMTPMessage *)message;
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error;

@end

@interface SKPSMTPMessage : NSObject
{
    NSString *login;
    NSString *pass;
    NSString *relayHost;
    NSArray *relayPorts;
    
    NSString *subject;
    NSString *fromEmail;
    NSString *toEmail;
    NSArray *parts;
    
    //NSOutputStream  *outputStream;
    //NSInputStream *inputStream;
    
    BOOL requiresAuth;
    BOOL wantsSecure;
    BOOL validateSSLChain;
    
    SKPSMTPState sendState;
    BOOL isSecure;
    NSMutableString *inputString;
    
    // Auth support flags
    BOOL serverAuthCRAMMD5;
    BOOL serverAuthPLAIN;
    BOOL serverAuthLOGIN;
    BOOL serverAuthDIGESTMD5;
    
    // Content support flags
    BOOL server8bitMessages;
    
    //id <SKPSMTPMessageDelegate> delegate;
    
    NSTimeInterval connectTimeout;
    
    NSTimer *connectTimer;
    NSTimer *watchdogTimer;
}

@property(nonatomic, retain) NSString *login;
@property(nonatomic, retain) NSString *pass;
@property(nonatomic, retain) NSString *relayHost;

@property(nonatomic, retain) NSArray *relayPorts;
@property(nonatomic, assign) BOOL requiresAuth;
@property(nonatomic, assign) BOOL wantsSecure;
@property(nonatomic, assign) BOOL validateSSLChain;

@property(nonatomic, retain) NSString *subject;
@property(nonatomic, retain) NSString *fromEmail;
@property(nonatomic, retain) NSString *toEmail;
@property(nonatomic, retain) NSArray *parts;

@property(nonatomic, assign) NSTimeInterval connectTimeout;

@property (nonatomic, assign) id <SKPSMTPMessageDelegate> __unsafe_unretained delegate;
//@property (retain) NSInputStream *inputStream;
//@property (retain) NSOutputStream  *outputStream;

- (BOOL)send;

@end