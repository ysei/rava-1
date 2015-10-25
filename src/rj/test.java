
import java.lang.*;
import java.util.*;

class test{
  static int sum = 5;
  public static void main(String args[]){
    // ok
/*
    exception_test();
    string_test();
    integer_test();
    hashmap_test();
    double_test();
    math_test();
    object_test();
    thread_test();
 */
    // speed_test();
    
    // ng
    //gc_test();
    
  }
  int ar_[];
  public test(){
    ar_ = new int[128];
  }
  public static void gc_test(){
    for(int i=0;i<1000000;i++){
      test t = new test();
    }
  }
  public static int get_sum(){
    return sum;
  }
  
  public static void speed_test(){
    long n = 0;
    // 1000000
    for(int i=0;i<1000000;i++){
      n++;
    }
    // ruby -e 'n=0;(1000000).times{n+=1};puts n'
    // 0m0.781s

    // ruby rava.rb
    // 1m34.343s
    
    //out(n);
    //System.out.println(n);
  }
  
  public static void object_test(){
    Object o1 = "hoe";
    Object o2 = "hoe";
    out(o1.hashCode());
    out(o2.hashCode());
    if(o1.equals(o2)){
      out("equal");
    }
    else{
      out("not...");
    }
  }
  public static void math_test(){
    out(Math.max(1,3));
    out(Math.max(1.00001,1.00002));
  }
  public static void double_test(){
    double d = 3.5;

    int i = (int)(d * d * d * d);
    out(i);
  }
  public static void hashmap_test(){
    HashMap hm = new HashMap();
    hm.put("a","aaa");
    hm.put("b","bbb");
    hm.put("c","ccc");
    hm.put("a","aaaaaa");

    out((String)hm.get("a"));
    out((String)hm.get("b"));
    out((String)hm.get("c"));
  }
  public static void thread_test(){
    MyThread mt = new MyThread(new test());
    

    mt.start();
  }
  
  public static void excep_test_h() throws Exception{
    throw new MyException();
  }
  public static void integer_test(){
    int n=0;
    for(int i=0;i<100;i++){
      n += i;
    }
    out(n);
  }
  public static void string_test(){
    String str = "‚ ‚¢‚¤‚¦‚¨";
    out(str);
    out(str.length());
  }
  
  public static void exception_test(){
    int n=1;
    try{
      if(n==1){
        excep_test_h();
      }
    }
    catch(Exception e){
      out("throwed");
    }
    finally{
      out("finally");
    }
  }
  
  native static public void out(String str);
  native static public void out(int n);
  native static public void out(long l);
  native static public void out(double d);
  
  native public void iout(String str);
}

class MyThread extends Thread{
  private test T;
  public MyThread(test t){
    T = t;
  }
  public void run(){
    int n = 0;
    for(int i=0;i<100000;i++){
      n += i;
    }
    T.out(n);
  }
}

class MyException extends Exception{

}
