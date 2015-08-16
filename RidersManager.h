//
//  RidersManager.h
//  BmwApp
//
//  Created by Jose Luis Rodriguez on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface RidersManager : NSObject


@property (nonatomic, strong) MCSession *session;

+(id)sharedManager;
+(NSString *)userFromPeer:(MCPeerID *)peer;
+(NSString *)objFromPeer:(MCPeerID *)peer;
-(void)startBrowsing;
-(void) sendRequestToPeer:(MCPeerID *)peer;


@end
