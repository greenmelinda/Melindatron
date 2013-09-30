// Syphon scrape for PixelPusher with ZigZag support
// by jas@heroicrobot.com, evil@heroicrobot.com
//
// IMPORTANT:
//
// Set canvasW and canvasH to some multiple of the number of pixels in
// your array.  In this example, we ahve a 60x32 array, and set our W/H
// to 600 x 320.  You also want to set your Syphon output to this size
//
// If you using a zig-zag configuration of cut strips
// (http://i.imgur.com/oMHyaBd.png for example)
// you want to set stride to the number of LEDs in each cut strip.
//
// Otherwise, you want to set it to 240 (or whatever the uncut length
// of each strip is)

import codeanticode.syphon.*;
import hypermedia.net.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;

import processing.core.*;
import java.util.*;

DeviceRegistry registry;

SyphonClient client;
PGraphics canvas;

boolean ready_to_go = true;
int lastPosition;
int canvasW = 600;
int canvasH = 320;
int stride = 60;
TestObserver testObserver;



void setup() {
  size(canvasW, canvasH, P3D);
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  background(0);
  client = new SyphonClient(this, "Modul8", "Main View");
}




void draw() {
  if (client.available()) {
    canvas = client.getGraphics(canvas);
    image(canvas, 0, 0, width, height);
  }  
  scrape();
}

void stop()
{
  super.stop();
}

