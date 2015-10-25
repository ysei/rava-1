
class StringTest{
  public static void main(String args[]){
    System.out.println("‚ ‚¢‚¤‚¦‚¨".length());
    char ary[] = "‚ ‚¢‚¤‚¦‚¨".toCharArray();
    for(int i=0;i<ary.length;i++){
      System.out.println((int)ary[i]);
    }
    for(int i=0;i<ary.length;i++){
      System.out.println(ary[i]);
    }
    
  }
}

