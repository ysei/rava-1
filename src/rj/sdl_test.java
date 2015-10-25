/**
  SDL ‚ðŽg‚Á‚½ƒfƒ‚
  
  
 */


import svm.*;
import java.lang.*;

class sdl_test{
  public void main(String str[]){
    my_sdl s = new my_sdl();
    circle_thread ci;
    // to load StrinctMath
    Math.sin(0);
    
    final int num = 3;
    //if(false)
      for(int i=0;i<num;i++){
      // ci = new circle_thread(s,i * 3,i * (640 / num),i * (480 / num) , 3 * i);
      ci = new circle_thread(s,		// sdl
                             30,	// size
                             (int)(Math.random() * 640.0), // center x
                             (int)(Math.random() * 480.0),  // center y
                             (int)(Math.random() * 50 + 5),    // center y
                             0xff00ff * (i+1) // color
                             );
      ci.setPriority(1);
      ci.start();
    }
    while(s.poll_event()){
      s.move();
//      if(n++<100){
//       s.move();
//        n=0;
 //     }
    }
  }
}


class circle_thread extends Thread{
  svm.sdl sdl;
  private int cx;
  private int cy;
  private int len;
  private int size;
  private double rad;
  private int color;

  private int x,y;
  public circle_thread(svm.sdl s,int sz,int x,int y,int l,int c){
    sdl  = s;
    size = sz;
    cx   = x;
    cy   = y;
    len  = l;
    color = c;
  }
  private final int screen_x = 800;
  private final int screen_y = 600;
  
  public void run(){
    while(sdl.is_live()){
      // sdl.sleep();
      draw();
    }
  }
  protected void draw(){
    boolean ef = false;
    boolean df = false;
    int ox = x;
    int oy = y;
    // erace before
    if(ox > 0 && ox < screen_x - size &&
       oy > 0 && oy < screen_y - size){
      ef = true;
      sdl.fill_rect(x,y,size,size,0);
//      sdl.update(x,y,size,size);
    }
    x = (int)((double)len * Math.cos(rad)) + cx;
    y = (int)((double)len * Math.sin(rad)) + cy;
    // clipping
    if(x > 0 && x < screen_x - size &&
       y > 0 && y < screen_y - size){

      sdl.fill_rect(x,y,size,size,color);
//      sdl.update(x,y,size,size);
    }
    if(ef || df){
      if(ef && df){
        int w,h;
        int rx,ry;
        rx = Math.min(x,ox);
        ry = Math.min(y,oy);
        w  = Math.max(x,ox) + size - rx;
        h  = Math.max(y,oy) + size - ry;
        sdl.update(rx,ry,w,h);
      }
      else if(ef){
        // erace only
        sdl.update(ox,oy,size,size);
      }
      else{
        // draw only
        sdl.update(x,y,size,size);
      }
    }
    rad += 0.1;
  }
}

/*
class square_thread extends shape_thread{
  private int x = 0;
  private int y = 0;

  public void run(){
    while(s.is_live()){
      s.sleep(1);
      draw();
    }
  }
  draw
}
*/

class my_sdl extends svm.sdl{
  public my_sdl(){
    x = 100; y = 100;
  }

  ///////////////////////////////////////////////////
  protected void mouse_ldown(int x,int y){
  }
  protected void mouse_move(int x,int y){
//    fill_rect(x,y,10,10,map_rgb(80,80,80));
//    update(x,y,10,10);
  }
  protected void key_down(int sym){
    is_move = true;
    if(sym == SDLK_UP || sym == SDLK_DOWN){
      axis = 1; value = sym == SDLK_UP ? -1 : 1;
      is_move = true;
    }
    else if(sym == SDLK_LEFT || sym == SDLK_RIGHT){
      axis = 0; value = sym == SDLK_LEFT ? -1 : 1;
      is_move = true;
    }
    move_();
    super.key_down(sym);
  }
  protected void key_up(int sym){
    is_move = false;
  }

  protected void joy_axis(int which,int axis,int value){
    // svm.out.println("pad : " + which + " , axis : " + axis + " , value : " + value);
    this.axis  = axis;
    this.value = value;
    this.is_move = value == -1 ? false : true;
    move_();
  }
  protected void joy_button_up(int which,int button){
    // svm.out.println("pad : " + which + " , button : " + button);
  }
  protected void joy_button_down(int which,int button){
    // svm.out.println("pad : " + which + " , button : " + button);
    if(button == 0){
      w += 3;
      h += 3;
      move_();
    }
    else if(button == 1){
      w -= 3;
      h -= 3;
      move_();
    }
  }
  private int x,y;
  private int w = 50;
  private  int h = 50;
  
  private int axis,value;
  private boolean is_move;

  public void move(){
    if(is_move == true){
      move_();
    }
  }
  public void move_(){
    fill_rect(x,y,w,h,map_rgb(0,0,0));
    update(x,y,w,h);
    if(axis == 0){
      // ‰¡
      if(value > 0){
        x += 10;
        if(x >= 640 - w){
          x = 640 - w;
        }
      }
      else if(value < 0){
        x -= 10;
        if(x < 0){
          x = 0;
        }
      }
      else{
        return;
      }
    }
    else{
      if(value > 0){
        y += 10;
        if(y >= 480 - h){
          y = 480 - h;
        }
      }
      else if(value < 0){
        y -= 10;
        if(y < 0){
          y = 0;
        }
      }
      else{
        return;
      }
    }
    // svm.out.println("x : " + x + " , y : " + y);
    fill_rect(x,y,w,h,0xffffff);
    update(x,y,w,h);
  }
}


