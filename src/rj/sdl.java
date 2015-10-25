/**
  SDL wrapper class for svm
 */


package svm;
//import svm.out;
import svm.sdl_native;

public class sdl extends sdl_const{
  
  /////////////////////////////////////////////////////////////////////
  // methods

  /**
    VIDEO / JOYSTICK ������������
   */
  public sdl(){
    //
    init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK);
  }
  /**
    ������ sdl �C���X�^���X�̏�ɍ��
    �����������Ȃ�
   */
  public sdl(sdl s){
    my_sdl = s;
    my_screen = s.my_screen;
  }

  /**
    SDL_SWSURFACE
    */
  public boolean init(int type){
    int ret = 0;
    ret |= sdl_native.SDL_Init(type);
    my_screen = sdl_native.SDL_SetVideoMode(800,600,16,SDL_HWSURFACE);

    return ret != 0 && my_screen != 0;
  }
  // SDL quit
  public void quit(){
    //
    if(my_sdl == null){
      // �����̂��̂�����Ȃ�A��������s����
      my_screen = 0;
      sdl_native.SDL_Quit();
    }
  }
  public void send_quit(){
    sdl_native.send_quit_event();
  }
  public boolean is_live(){
    return sdl_native.is_live();
  }

  /**
    �C�x���g���|�[�����O����
    quit �Ȃ�A0 ��Ԃ�
    */
  public boolean poll_event(){
    if(sdl_native.SDL_PollEvent(this) != 0){
      if(ev_type == SDL_QUIT){
        // quit
        quit();
        return false;
      }
      else if(ev_type == SDL_KEYDOWN){
        // key down
        key_down(ev_key_sym);
      }
      else if(ev_type == SDL_KEYUP){
        // key up
        key_up(ev_key_sym);
      }
      else if(ev_type == SDL_MOUSEMOTION){
        // mouse motion
        mouse_move(ev_x,ev_y);
      }
      else if(ev_type == SDL_MOUSEBUTTONDOWN){
        // mouse button down
        if(ev_button == SDL_BUTTON_LEFT){
          mouse_ldown(ev_x,ev_y);
        }
        else if(ev_button == SDL_BUTTON_RIGHT){
          mouse_rdown(ev_x,ev_y);
        }
      }
      else if(ev_type == SDL_MOUSEBUTTONUP){
        // mouse button up
        if(ev_button == SDL_BUTTON_LEFT){
          mouse_lup(ev_x,ev_y);
        }
        else if(ev_button == SDL_BUTTON_RIGHT){
          mouse_rup(ev_x,ev_y);
        }
      }
      // joystick
      else if(ev_type == SDL_JOYBUTTONDOWN){
        joy_button_down(ev_which,ev_button);
      }
      else if(ev_type == SDL_JOYBUTTONUP){
        joy_button_up(ev_which,ev_button);
      }
      else if(ev_type == SDL_JOYAXISMOTION){
        joy_axis(ev_which,ev_axis,ev_value);
      }
      // svm.out.println("event : " + ev_type);
    }
    return true;
  }

  // �C�x���g�������������ɌĂ΂��
  // �Ă��Ɓ[�ɔh����������ĉ�����
  protected void mouse_move(int x,int y){
  }
  protected void mouse_ldown(int x,int y){
  }
  protected void mouse_lup(int x,int y){
  }
  protected void mouse_rdown(int x,int y){
  }
  protected void mouse_rup(int x,int y){
  }
  /**
    �f�t�H���g�ł́A
    sym == SDLK_RETURN : FullScreen
    sym == SDLK_ESCAPE : Exit

    ������
    */
  protected void key_down(int sym){
    if(sym == SDLK_ESCAPE){
      send_quit();
    }
    else if(sym == SDLK_RETURN){
    sdl_native.toggle_fullscreen(my_screen);
      // svm.out.println("full screen toggle");
    }
    // svm.out.println("key : " + sym);
  }
  protected void key_up(int sym){
  }
  /**
    �����L�[
    axis ->
           0 : ����
           1 : ����
    value ->
           -32768 : ���������̌���
            32767 : ���������̌���
                0 : �������Ƃ�
    �����͉E�A������
   */
  protected void joy_axis(int which,int axis,int value){
  }
  protected void joy_button_up(int which,int button){
  }
  protected void joy_button_down(int which,int button){
  }
  
  // ����̂��H�@����Ȃ�
  protected void joy_hat(int which,int hat,int value){
  }
  protected void joy_ball(int which,int ball,int xrel,int yrel){
  }
  

  
  /////////////////////////////////
  // video function
  /**

   */
  public void update(int x,int y,int w,int h){
    sdl_native.SDL_UpdateRect(my_screen,x,y,w,h);
  }
  /**
    �������w�肵�Ȃ��ƑS��ʏ�������
   */
  public void update(){
    sdl_native.SDL_UpdateRect(my_screen,0,0,0,0);
  }
  
  
  /**
    This function performs a fast fill of the given rectangle with color.
   */
  public void fill_rect(int x,int y,int w,int h,int color){
    sdl_native.SDL_FillRect(my_screen,x,y,w,h,color);
  }

  public int map_rgb(int r,int g,int b){
    return sdl_native.SDL_MapRGB(my_screen,r,g,b);
  }
  /**
    �w�肳�ꂽBMP�t�@�C���̓��e��\������
   */
  public void show_bmp(String name){
    sdl_native.show_bmp(my_screen,name);
  }

  

  /**
    Sleep
    */
  public void sleep(long time){
    long t = java.lang.System.currentTimeMillis();
    // svm.out.println("time : "+t + " t : " + time);
    t += time;
    while(t > java.lang.System.currentTimeMillis()){
      //
    }
  }

  
  /////////////////////////////////
  // event parameter

  // all events common
  private int ev_type;
  private int ev_state;
  private int ev_xrel;
  private int ev_yrel;
  private int ev_button;

  // mouse common
  private int ev_x;
  private int ev_y;

  // joystick common
  private int ev_which;
  private int ev_value;
  
  // key event
  private int ev_key_sym;	// sdl virtual key sym

  // joystic axis specify
  private int ev_axis;
  
  // joystic hat specify
  private int ev_hat;

  // joystic ball specify
  private int ev_ball;

  // my screen surface
  int my_screen;


  // wrapper
  sdl my_sdl;
}

