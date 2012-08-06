import processing.video.*;
Capture myCapture;
//Capture startCapture;
PImage startCapture;

int i;
int width=1280;
int height=800;
void setup() 
{
  size(width, height);
  i=0;
  // The name of the capture device is dependent on
  // the cameras that are currently attached to your 
  // computer. To get a list of the 
  // choices, uncomment the following line 
  // println(Capture.list());
  
  // To select the camera, replace "Camera Name" 
  // in the next line with one from Capture.list()
  // myCapture = new Capture(this, width, height, "Camera Name", 30);
  
  // This code will try to use the camera used llast
  myCapture = new Capture(this, width, height, 30);

  startCapture = createImage(width,height,ARGB );
  for (int i=0; i < startCapture.pixels.length; i++) {
   startCapture.pixels[i] = color(0, 90, 102, i%startCapture.width * 2);
  } 
}

void captureEvent(Capture myCapture) {
  myCapture.read();
  
  //this should flip it left to right, but I am getting two images
  //pushMatrix();
  //scale(-1.0, 1.0);
  //image(myCapture,-myCapture.width,0);
  //popMatrix();
}

void mouseClicked() {
  //myCapture.read();
  captureEvent(myCapture);
  startCapture.copy(myCapture,0,0,myCapture.width, myCapture.height,0,0, myCapture.width, myCapture.height);
  myCapture.save("last_image.jpg");
}

void draw() {
  // wait a timeout to make sure the image is stabalized.  This is the original posing image.
  if (i == 40) {
    println("copying now)");
    startCapture.copy(myCapture,0,0,myCapture.width, myCapture.height,0,0, myCapture.width, myCapture.height);
    //startCapture.filter(GRAY);
    //startCapture.filter(THRESHOLD,0.5);
    //startCapture.filter(POSTERIZE,4);
    //image(startCapture, 0, 0,800,800);
  }
  i++;
  println(i);
  
  //now two images exisrt, startCapture and myCapture.  myCapture is being updated.
  if (i>40) {
    image(startCapture, 0, 0,width,height);
    // 255,64 works okay, but I want more punch for the original image
    //tint(255,64);
    tint(255,48);

  }
  
  //image(myCapture,0,0,800,400);
  //myCapture.filter(THRESHOLD,0.5);
  //myCapture.filter(INVERT);
  
 // myCapture.blend(startCapture, 0,0, 800, 800, 0, 0, 800, 800, SOFT_LIGHT);
 // image(myCapture,0,0,800,800);
  
  //this works semi okay.
  image(myCapture,0,0,width,height);
  
  //font = loadFont("FFScala-32.vlw"); 
  //textFont(font); 
  text("Portrait Position Confidence Monitor. Click on image to reset pose. Stay confident", 5, 20); 
  fill(0, 102, 153);
 // delay(100);
}
