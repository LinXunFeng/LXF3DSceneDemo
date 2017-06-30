//
//  ViewController.m
//  LXF3DSceneDemo
//
//  Created by 林洵锋 on 2017/6/30.
//  Copyright © 2017年 LXF. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

/** scnView */
@property(nonatomic, strong) SCNView *scnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    //    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"artLXF.scnassets/Menchi.dae"];
    //    SCNScene *scene = [SCNScene sceneWithURL:documentsDirectoryURL options:nil error:nil];
    //
    //    SCNNode *mechiNode = scene.rootNode.childNodes.firstObject;
    //    mechiNode.transform = SCNMatrix4MakeScale(5, 5, 5);
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/Menchi.dae"];
    SCNNode *mechiNode = scene.rootNode.childNodes.firstObject;
    mechiNode.transform = SCNMatrix4MakeScale(5, 5, 5);
    
    // 绕 y轴 一直旋转
    SCNNode *node = scene.rootNode.childNodes.firstObject;
    SCNAction *action = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:1]];
    [node runAction:action];
    
    // create and add a camera to the scene
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // place the camera
    cameraNode.position = SCNVector3Make(0, 3, 15);
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    // retrieve the ship node
    SCNNode *ship = [scene.rootNode childNodeWithName:@"Menchi" recursively:YES];
    
    // animate the 3d object
    [ship runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
    
    // retrieve the SCNView
    SCNView *scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    [self.view addSubview:scnView];
    
    // set the scene to the view
    scnView.scene = scene;
    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = YES;
    
    // show statistics such as fps and timing information
    scnView.showsStatistics = YES;
    
    // configure the view
    scnView.backgroundColor = [UIColor blackColor];
    
    
    
    self.scnView = scnView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTest:)];
    [scnView addGestureRecognizer:tap];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"TestYJ.dae" withExtension:nil];
//
//    SCNSceneSource *data = [SCNSceneSource sceneSourceWithURL:url options:nil];
//    SCNNode *node = [data entryWithIdentifier:@"TestYJ" withClass:[SCNNode class]];
////    SCNNode *node = [data entryWithIdentifier:@"TestYJ" withClass:[SCNNode class]];
//    if (node != nil) {
//        node.position = SCNVector3Make(0, 0, -10);
//        node.name = @"TestYJ";
//        [scene.rootNode addChildNode:node];
//    }

//    SCNScene *myScene = [SCNScene sceneNamed:@"TestYJ.dae"];
//    SCNNode *lxfnode = myScene.rootNode.childNodes.firstObject;
//    if (lxfnode) {
//        [scene.rootNode addChildNode:lxfnode];
//    }
}

- (void)tapTest:(UITapGestureRecognizer *)tap {
    //    CGPoint p = [tap locationInView:self.scnView];
    //    NSArray *hitResults = [self.scnView hitTest:p options:nil];
    //    NSLog(@"p : %@", NSStringFromCGPoint(p));
    
    SCNVector3 projectedOrigin = [self.scnView projectPoint:SCNVector3Zero];
    CGPoint vp = [tap locationInView:self.scnView];
    SCNVector3 vpWithZ = SCNVector3Make(vp.x, vp.y, projectedOrigin.z);
    SCNVector3 worldPoint = [self.scnView unprojectPoint:vpWithZ];
    NSLog(@"x: --- %f y: --- %f z: --- %f", worldPoint.x, worldPoint.y, worldPoint.z);
}


@end
