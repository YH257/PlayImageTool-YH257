//
//  ImageProcessingViewController.m
//  ImageProcessing
//
//  Created by Evangel on 10-11-23.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ImageProcessingViewController.h"
#import "ImageUtil.h"

@implementation ProcessingImageView
@synthesize delegate;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([(NSObject*)delegate respondsToSelector:@selector(tapOnCallback:)])
	{
		[delegate tapOnCallback:self];
	}
}
@end

#pragma mark -

@implementation ImageProcessingViewController
@synthesize startItem,segc,saveItem,imageV,toolbar,navBar;

-(id)initWithCoder:(NSCoder *)aDecoder
{
	if(self = [super initWithCoder:aDecoder])
	{
		self.wantsFullScreenLayout = YES;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		
	}
	return self;
}

-(void)viewDidLoad
{	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    
    [self.navigationController setNavigationBarHidden:YES];
    
	imageV.delegate = self;
	imageV.userInteractionEnabled = YES;
    
    UIImage *resizedImg = [ImageUtil image:self.imgData fitInSize:CGSizeMake(320.0, 480.0)];
    currentImage = [resizedImg copy];
    self.imageV.image = resizedImg;
	show = YES;
}

- (void)viewDidUnLoad 
{
	self.startItem = nil;
	self.segc = nil;
	self.imageV = nil;
	self.toolbar = nil;
	self.navBar = nil;
	[super viewDidLoad];
}


#pragma mark -
-(IBAction)begin:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    /*
	UIActionSheet *ac = nil;
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		ac = [[UIActionSheet alloc] initWithTitle:@"-Photo Source-" 
																		 delegate:self 
														cancelButtonTitle:@"Cancel" 
											 destructiveButtonTitle:nil 
														otherButtonTitles:@"Photo Lib",@"Camera",nil];
	}
	else 
	{
		ac = [[UIActionSheet alloc] initWithTitle:@"-Photo Source-" 
																		 delegate:self 
														cancelButtonTitle:@"Cancel" 
											 destructiveButtonTitle:nil 
														otherButtonTitles:@"Photo Lib",nil];
	}
	ac.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[ac showInView:self.view];
     */
}

-(IBAction)effectChange:(id)sender
{
	UISegmentedControl *sg = (UISegmentedControl*)sender;
	if(currentImage)
	{
		UIImage *outImage = nil;
		if(sg.selectedSegmentIndex == 0)
		{
			self.imageV.image = currentImage;
		}
		
		if(sg.selectedSegmentIndex == 1)
		{
			outImage = [ImageUtil blackWhite:currentImage];
		}
		if(sg.selectedSegmentIndex == 2)
		{
			outImage = [ImageUtil cartoon:currentImage];
		}
		if(sg.selectedSegmentIndex == 3)
		{
			outImage = [ImageUtil bopo:currentImage];
		}
		if(sg.selectedSegmentIndex == 4)
		{
			outImage = [ImageUtil memory:currentImage];
		}
		if(sg.selectedSegmentIndex == 5)
		{
			outImage = [ImageUtil scanLine:currentImage];
		}
		if(outImage)
		{
			self.imageV.image = outImage;
		}
	}
}

- (void) image: (UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo;
{
	UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"Save Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[al show];
	self.saveItem.enabled = YES;
}

-(IBAction)save:(id)sender
{
	if(self.imageV.image)
	{
		self.saveItem.enabled = NO;
		UIImageWriteToSavedPhotosAlbum(self.imageV.image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL); 
	}
}

-(void)snap:(id)sender
{
	if(imagePickerController)
	{
		[imagePickerController takePicture];
	}
}

-(void)close:(id)sender
{
	if(imagePickerController)
	{
		[self dismissModalViewControllerAnimated:YES];
	}
}
#pragma mark -
-(void)tapOnCallback:(ProcessingImageView*)imageView
{
	[UIView beginAnimations:@"aa" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3];
	
	[[UIApplication sharedApplication] setStatusBarHidden:show animated:NO];
	if(show)
	{
		self.toolbar.alpha = 0.0;
		self.navBar.alpha = 0.0;
	}
	else 
	{
		self.toolbar.alpha = 1.0;
		self.navBar.alpha = 1.0;
	}
	[UIView commitAnimations];
	show = !show;
}

#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if(buttonIndex == 0)
		{
			imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:imagePickerController animated:YES];
		}
		if(buttonIndex == 1) 
		{
			UIView *cameraView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
			cameraView.backgroundColor = [UIColor clearColor];
			cameraView.autoresizesSubviews = YES;
			
			UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, cameraView.frame.size.height-53.0, cameraView.frame.size.width, 53.0)];
			bottomBar.backgroundColor = [UIColor whiteColor];
			bottomBar.autoresizesSubviews = YES;
			
			UIButton *snapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[snapBtn setTitle:@"Snap" forState:UIControlStateNormal];
			snapBtn.frame = CGRectMake(5.0, 9.0, 60.0, 33.0);
			[snapBtn addTarget:self action:@selector(snap:) forControlEvents:UIControlEventTouchUpInside];
			
			UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[closeBtn setTitle:@"Cancel" forState:UIControlStateNormal];
			closeBtn.frame = CGRectMake(bottomBar.frame.size.width-60.0-5.0, 9.0, 60.0, 33.0);
			[closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
			
			[bottomBar addSubview:snapBtn];
			[bottomBar addSubview:closeBtn];
			
			[cameraView addSubview:bottomBar];
			
			
			imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
			imagePickerController.showsCameraControls = NO;
			imagePickerController.cameraOverlayView = cameraView;
			
			[self presentModalViewController:imagePickerController animated:YES];
		}
	}
	else 
	{
		if(buttonIndex == 0)
		{
			imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:imagePickerController animated:YES];
		}
	}
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mediaType isEqualToString:@"public.image"])
	{
		UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
		NSLog(@"found an image");
		
		UIImage *resizedImg = [ImageUtil image:image fitInSize:CGSizeMake(320.0, 480.0)];
		currentImage = [resizedImg copy];
		self.imageV.image = resizedImg;
	}
	//picker.cameraViewTransform = CGAffineTransformIdentity;
	
	[self.segc setSelectedSegmentIndex:0];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	
	[self dismissModalViewControllerAnimated:YES];
}
@end
