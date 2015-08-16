//
//  RidersManager.m
//  BmwApp
//
//  Created by Jose Luis Rodriguez on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//
#define OBJSEPARATOR @"/0F0F0"

#import "RidersManager.h"
#import <Parse/Parse.h>

@interface RidersManager()<MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate>


@property (nonatomic, strong) MCNearbyServiceAdvertiser *advertiser;
@property (nonatomic, strong) MCPeerID *peerId;
@property (nonatomic, strong) MCNearbyServiceBrowser *browser;

@end

@implementation RidersManager

+(id)sharedManager{
    
    static RidersManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
    
}

-(id)init{
    
    if (self = [super init]) {
        
        
        self.peerId = [[MCPeerID alloc] initWithDisplayName:[NSString stringWithFormat:@"%@%@%@",[[PFUser currentUser] valueForKey:@"name"],OBJSEPARATOR,[PFUser currentUser].objectId ] ];
        self.advertiser = [[MCNearbyServiceAdvertiser alloc]initWithPeer:self.peerId discoveryInfo:nil serviceType:@"htpbmw-txtchat"];
        self.advertiser.delegate = self;
        [self.advertiser startAdvertisingPeer];
        
        
        self.session = [[MCSession alloc] initWithPeer:self.peerId];
        self.session.delegate=self;
        
        
        
    }
    return self;
    
}

-(void)startBrowsing{
    
    
    self.browser = [[MCNearbyServiceBrowser alloc]initWithPeer:self.peerId serviceType:@"htpbmw-txtchat"];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
    
    
}

-(void)sendRequestToPeer:(MCPeerID *)peer{
    
    [self.browser invitePeer:peer toSession:self.session withContext:nil timeout:60];
    
}

-(void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error{
    
    NSLog(@"failed");
    
}

-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info{
    
    NSLog(@"FOUND");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foundPeer" object:nil userInfo:@{@"peer":peerID}];
    
    [self sendRequestToPeer:peerID];
    
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lostPeer" object:nil userInfo:@{@"peer":peerID}];
    
    
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler{
    
    invitationHandler(YES,self.session);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"invitation" object:nil userInfo:@{@"peer":peerID,@"invitation":invitationHandler}];
    
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
    if(state==MCSessionStateConnected){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotNewRider" object:nil userInfo:@{@"peer":peerID}];
        
        
        
    }
    else if (state == MCSessionStateNotConnected){
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotNewRider" object:nil userInfo:@{@"peer":peerID}];

    }
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    
    
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
    
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
    
    
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
}



-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error{
    
    NSLog(@"didnt started ");
}


+(NSString *)userFromPeer:(MCPeerID *)peer{
    
    NSString *dsp = peer.displayName;
    
    
    NSRange orange = [dsp rangeOfString:OBJSEPARATOR];
    
    dsp = [dsp substringToIndex:orange.location];
    
    
    return dsp;
}

+(NSString *)objFromPeer:(MCPeerID *)peer{
    NSString *dsp = peer.displayName;
    
    NSRange range = [dsp rangeOfString:OBJSEPARATOR];
    
    return [dsp substringFromIndex:range.location+range.length];
}


@end
