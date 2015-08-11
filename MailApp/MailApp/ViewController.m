//
//  ViewController.m
//  MailApp
//
//  Created by Alejandro Guerra Carbonell on 18/08/14.
//  Copyright (c) 2014 Alejandro Guerra Carbonell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize estado;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	// Do any additional setup after loading the view, typically from a nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendMail:(id)sender {
    //Primero se verifica si se puede enviar el correo desde el dispositivo.
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
        
        email.mailComposeDelegate = self;
        
        //Asunto del correo...
        [email setSubject:@"Correo desde el iphone"];
        
        //Contenido del correo inicial...
        NSMutableString *cuerpo = [[NSMutableString alloc] init];
        //[cuerpo appendString:@" Probando el envio desde APP"];
        [cuerpo appendString:@"Eyyy enviando desde una app el correo."];
        
        
        //Se lo asignamos al cuerpo y que lo interprete como HTML.
        [email setMessageBody:cuerpo isHTML:NO];
        
        
        //Adejuntamos imagen desde el tlf.
        UIImage *imagen = [UIImage imageNamed:@"images.jpeg"];
        NSData *imagenData = UIImageJPEGRepresentation(imagen, 5);
        [email addAttachmentData:imagenData mimeType:@"image/jpeg" fileName:@"images"];
        
        //Mostramos la ventana modal con la interfaz del correo.
        [self presentViewController:email animated:YES completion:nil];
    }else{
        //Alerta para cuando no se pueda enviar el correo.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedString(@"Dispositivo no lo soporta", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}

//Para en caso de dar información acerca de si se ha cancelado el correo u otro error.
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            self.estado.text = @"La operación ha sido cancelada.";
            break;
        case MFMailComposeResultSaved:
            self.estado.text = @"Correo guardado en borradores.";
            break;
        case MFMailComposeResultSent:
            self.estado.text = @"Correo enviado correctamente.";
            break;
        case MFMailComposeResultFailed:
            self.estado.text = @"No se ha podido enviar el correo.";
            break;
        default:
            break;
    }
    
    //Cerramos la ventana modal del envio de correo.
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


@end





