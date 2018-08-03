//
//  ImageProcessingViewController.h
//  ImageProcessing
//
//  Created by Evangel on 10-11-23.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol ProcessingImageViewDelegate;

@interface ProcessingImageView : UIImageView

@property (nonatomic,assign) id <ProcessingImageViewDelegate> delegate;

@end

@protocol ProcessingImageViewDelegate
-(void)tapOnCallback:(ProcessingImageView*)imageView;
@end

//-----------------------------
@interface ImageProcessingViewController : UIViewController <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ProcessingImageViewDelegate>
{
	UIBarButtonItem *startItem;
	UIBarButtonItem *saveItem;
	UIToolbar *toolbar;
	UINavigationBar *navBar;
	UIImagePickerController *imagePickerController;
	
	UISegmentedControl *segc;
	ProcessingImageView *imageV;
	UIImage *currentImage;
	
	BOOL show;
}

@property(strong,nonatomic)UIImage *imgData;

@property (retain) IBOutlet UIBarButtonItem *startItem;
@property (retain) IBOutlet UIBarButtonItem *saveItem;
@property (retain) IBOutlet UISegmentedControl *segc;
@property (retain) IBOutlet UIImageView *imageV;
@property (retain) IBOutlet UIToolbar *toolbar;
@property (retain) IBOutlet UINavigationBar *navBar;

-(IBAction)begin:(id)sender;
-(IBAction)effectChange:(id)sender;
-(IBAction)save:(id)sender;
@end
