//
//  ImageProcessingViewController.m
//  ImageProcessing
//
//  Created by Evangel on 10-11-23.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ImageProcessingViewController.h"
#import "ImageUtil.h"
#import <UMShare/UMShare.h>
#import "XDShareSetFriendView.h"
#import "SVProgressHUD.h"

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
    
    XDShareSetFriendView *popView = [[XDShareSetFriendView alloc] initWithSelecetButtonBlock:^(NSInteger index) {
        [self shareSDKMethod:index];
    }];
    [popView showPopView];
    return;
    
	if(self.imageV.image)
	{
		self.saveItem.enabled = NO;
		UIImageWriteToSavedPhotosAlbum(self.imageV.image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL); 
	}
}


#pragma mark - 分享图片


-(void)shareSDKMethod:(NSInteger)index {
    
//    UMSocialPlatformType_WechatSession      = 1, //微信聊天
//    UMSocialPlatformType_WechatTimeLine     = 2,//微信朋友圈
//    UMSocialPlatformType_WechatFavorite
    
    if (index == 0) {
         [self addShareContent:UMSocialPlatformType_WechatSession];
    } else if (index == 1) {
        [self addShareContent:UMSocialPlatformType_WechatTimeLine];
        
    } else if (index == 2) {
        [self addShareContent:UMSocialPlatformType_Sina];
        
    } else if (index == 3) {
        
        [self addShareContent:UMSocialPlatformType_QQ];
    }else if (index == 4) {
        
        [self addShareContent:UMSocialPlatformType_Qzone];
    }
}

//添加分享的内容
- (void)addShareContent:(UMSocialPlatformType)platformType{
    
    UMShareImageObject *imgObject = [[UMShareImageObject alloc] init];
    imgObject.shareImage = self.imageV.image;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.shareObject = imgObject;

//
//    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", @""];
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    if (platformType == UMSocialPlatformType_Sina) {
//        messageObject.text = [NSString stringWithFormat:@"我正在使用客靠经纪端APP。着手帮助经纪人解决房源、客源、提升业务技能的问题，提供全方位、多角度的经纪服务 %@",urlStr];//文本和url放在text里
//        messageObject.title = @"客靠经纪端";
//    }
//
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"客靠经济端" descr:@"我正在使用客靠经纪端APP。着手帮助经纪人解决房源、客源、提升业务技能的问题，提供全方位、多角度的经纪服务" thumImage:[UIImage imageNamed:@"Icon"]];
//    shareObject.webpageUrl = urlStr;
//    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            if (error.code == 2008) {
                //应用未安装
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"该应用未安装"];
                });
            }
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
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


@end
