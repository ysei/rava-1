require 'sdl'

$rjn_svm_sdl_native_islive = false

class RJN_svm_sdl__native < RJNative

  # int SDL_SetVideoMode(int,int,int,int)
  def SDL_SetVideoMode jclass,arg,method,thread
    SDL.setVideoMode arg[0],arg[1],arg[2],arg[3]
    # raise 'unimplemented native method : SDL_SetVideoMode @ svm/sdl_native'
  end

  # int SDL_FillRect(int,int,int,int,int,int)
  def SDL_FillRect jclass,arg,method,thread
    # int SDL_FillRect(int screen, int x,int y,int w,int h, int color);
    # ... ‰½‚ð•Ô‚·‚ñ‚¾‚ë‚¤
    arg[0].fillRect arg[1],arg[2],arg[3],arg[4],arg[5]
    
    # raise 'unimplemented native method : SDL_FillRect @ svm/sdl_native'
  end

  # int SDL_PollEvent(svm.sdl)
  def SDL_PollEvent jclass,arg,method,thread
    ev = SDL::Event.new
    if ev.poll == 0
      # ƒCƒxƒ“ƒg–³‚µ
      return 0
    end
    obj = arg[0]

    obj['ev_type'] = ev.type
    
    case ev.type
    when SDL::Event::KEYDOWN , SDL::Event::KEYDOWN
      obj['ev_state']   = ev.keyPress?
      obj['ev_key_sym'] = ev.keySym
    when SDL::Event::JOYAXISMOTION
      obj['ev_which']   = ev.info[1]
      obj['ev_axis']    = ev.info[2]
      obj['ev_value']   = ev.info[3]
    when SDL::Event::JOYBUTTONDOWN,SDL::Event::JOYBUTTONUP
      obj['ev_which']   = ev.info[1]
      obj['ev_button']  = ev.info[2]
      obj['ev_state']   = ev.info[3]
    end
    
    # raise 'unimplemented native method : SDL_PollEvent @ svm/sdl_native'
  end

  # void send_quit_event()
  def send_quit_event jclass,arg,method,thread
    exit
    # raise 'unimplemented native method : send_quit_event @ svm/sdl_native'
  end

  # boolean is_live()
  def is_live jclass,arg,method,thread
    return $rjn_svm_sdl_native_islive
    # raise 'unimplemented native method : is_live @ svm/sdl_native'
  end

  # void SDL_UpdateRect(int,int,int,int,int)
  def SDL_UpdateRect jclass,arg,method,thread
    # void SDL_UpdateRect(int screen, int x, int y, int w, int h);
    arg[0].updateRect arg[1],arg[2],arg[3],arg[4]
    # raise 'unimplemented native method : SDL_UpdateRect @ svm/sdl_native'
  end

  # void show_bmp(int,java.lang.String)
  def show_bmp jclass,arg,method,thread

    raise 'unimplemented native method : show_bmp @ svm/sdl_native'
  end

  # void SDL_Quit()
  def SDL_Quit jclass,arg,method,thread
    $rjn_svm_sdl_native_islive = false
    SDL::quit
    # raise 'unimplemented native method : SDL_Quit @ svm/sdl_native'
  end

  # int SDL_Init(int)
  def SDL_Init jclass,arg,method,thread
    SDL::init arg[0]
    SDL::Joystick.open 0
    $rjn_svm_sdl_native_islive = true
    # raise 'unimplemented native method : SDL_Init @ svm/sdl_native'
  end

  # int SDL_MapRGB(int,int,int,int)
  def SDL_MapRGB jclass,arg,method,thread
    arg[0].mapRGB(arg[1],arg[2],arg[3])
    
    # raise 'unimplemented native method : SDL_MapRGB @ svm/sdl_native'
  end

  # void toggle_fullscreen(int)
  def toggle_fullscreen jclass,arg,method,thread
    sur = arg[0]
    SDL::setVideoMode sur.w,sur.h,sur.bpp,sur.flags ^ SDL::FULLSCREEN
    # raise 'unimplemented native method : toggle_fullscreen @ svm/sdl_native'
  end

end
