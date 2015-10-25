---------------------
	Rava / JavaVM on Ruby

		written by K.Sasada
			---------------------
	------------------------
-----------------------


$B"#(B 1 - Rava / JavaVM on Ruby

- Tue, 15 Oct 2002 09:47:06 +0900$B!"=i9F!#(B

$B""(B 1.1 $B$J$s$8$c$=$j$c(B

Ruby $B$G=q$$$?(B JavaVM $B$G$9!#(BJRuby $B$C$F$"$k$8$c$J$$$G$9$+!#$"$l$O!"(BJava 
$B$G(B Ruby $B%$%s%?!<%W%j%?F0$+$9$d$D$G$9$1$l$I$b!"$3$l$O!"(BRuby $B$G(B Java $B%P%$(B
$B%H%3!<%I$rF0$+$7$^$9!#(B

$B$I$&9M$($F$b!";H$&MxE@$C$F!JKX$I!KL5$$$h$&$J5$$b$7$^$9$,!#(B

$BC/$+9M$($F$=$&$G!"$@$1$I!J$=$NL50UL#$5$K!KC/$b:n$C$F$$$J$+$C$?!J0l1~!"(BGoogle
$BMM$OCN$i$J$+$C$?!K!#(B

$B$^$!!"%8%g!<%/$N0l$D$H$7$F$4>PMw$/$@$5$$!#(B

$B""(B 1.2 $B$D$+$&$H$&$l$7$$$R$H(B

$B$I$s$J?M$,;H$&$H$&$l$7$$$+$H?=$7$^$9$H!#(B

- JavaVM $BJY6/$7$?$$$1$I!"%I%-%e%a%s%HFI$`$NLLE]$@$J$!!"(BRuby 
  $B%=!<%9$N$[$&$,!"FI$`$N3Z$@$7$#!"$H$$$&?M!J$$$k$s$+$=$s$J$N!K(B
- $B$b$&!"(BRuby $B$7$+;H$$$?$/$J$$$1$I!"$7$g$&$,$J$/(B Java $B$r;H$&?M(B
  $B!J$&$l$7$$$N$+$[$s$H$K!K(B

$B>/$7$^$8$a$K!JI,;`$KMxE@$r9M$($F!K!"(B

- Java $B%M%$%F%#%V%a%=%C%I$r=q$-$?$$$1$l$I!"%W%m%H%?%$%W$r:n$j$?$$(B
  (Ruby $B%9%/%j%W%H$G%M%$%F%#%V%a%=%C%I$+$1$k$N$G!"%W%m%H%?%$%W$r:n$k$N$OJXMx$+$b$7$l$J$$(B)

$B$G$b!"$?$7$+(B JRuby $B$b$=$&$$$&$3$H$G$-$k$s$@$h$M$'!"3N$+!#0c$C$?$C$1!#(B

Java $B$N%W%m%0%i%`$,(B Ruby $B$+$i8F$Y$F$b!"$=$s$J$&$l$7$$$3$HL5$5$=$&$J5$$,(B
$B$9$k$7$J$!!#(B

$B""(B 1.3 $B$b$/$F$-(B

$B<+J,$NL\E*$G$9$,!#(B

- Ruby $B$NN}=,(B
- JavaVM $B$NI|=,(B
- $B:#8e$N8&5f$N$?$a!J$[$s$H$+!)!K(B
- $B8=<BF(Hr!JF05!$N(B 50% $B$/$i$$!K(B

$B""(B 1.4 $B$D$+$$$+$?(B

$B$^$:!"(Bjdk $B$H$C$F$-$F!"(Bjdk/jre/lib/rt.jar $B$r2rE`$7$F!"(B*.class $B$r$P$i$7$F(B
$B$/$@$5$$!#8G$^$C$F$k$H!"FI$a$^$;$s!#(B

$B$s$G!"F1$8%G%#%l%/%H%j$K(B $BNc$($P(B java/lang/* $B$rCV$$$F$*$-$^$9!#$=$s$G!"(B
$BE,Ev$KF0$+$7$?$$$b$N$r(B javac $B$G:n$C$F$/$@$5$$!#$"$H$OF0$+$9$@$1$G$9!#(B

>
ruby rava.rb [java class name] [args 1] [args 2] ...
>

$B$G!"F0$-$^$9!#B?J,!#(B

$B$^$?!"(B

>
ruby rjclass.rb [java class name]
>

$B$G!"%/%i%9%U%!%$%k$N>pJs$r!"$3$l$G$b$+!"$C$F$/$i$$I=<($7$^$9!#$A$g$C$H(B
$B$$$$$+$2$s$@$1$I!#(B

$B$^$?!"(B

>
ruby rjnative.rb [java class name]
>

$B$G!"%M%$%F%#%V%a%=%C%IDj5AMQ$N?w$rEG$-$^$9!#(B

$B""(B 1.5 $B$@$&$s$m!<$I(B

[[http://www.namikilab.tuat.ac.jp/~sasada/prog/raja001.lzh]]

Windows2000 Pro / ruby 1.6.7 mswin$BHG(B $B$@$1$GF0:n3NG'$7$F$$$^$9!#(B


$B""(B 1.6 $B$*$d$/$=$/(B

Ruby $B$HF1$8%i%$%;%s%9$G$*4j$$$7$^$9!#!J$H8@$C$F$*$/$H!"LLE]$,$J$$$i$7$$(B
$B!K!#(B

$B86B'!";d$KLBOG$,$+$+$i$J$$$h$&$K!#$"$H$O9%$-$K$7$F$/$@$5$$!#(B

$B%P%0Js9p$H$+!"MxMQJs9p$H$+$"$k$H!"$&$l$7$/;W$$$^$9!#(B

$B$"!"Cx:n8"$OJ|4~$7$^$;$s!#$H$$$&$+!"$G$-$^$;$s!)(B

$B""(B 1.7 $B$b$&$G$-$F$k$3$H(B

$B$H$j$"$($:JB$Y$F$_$^$7$?!#(B

- $B%P%$%H%3!<%IH>J,$/$i$$(B?
- $B%a%=%C%I8F$S=P$7(B
- $B%9%?%F%#%C%/%a%=%C%I8F$S=P$7(B
- $B%U%#!<%k%IFI$_=q$-(B
- $B%9%?%F%#%C%/%U%#!<%k%IFI$_=q$-(B
- $B%M%$%F%#%V%a%=%C%I$r(B ruby $B$G=q$-=q$-(B
- $B%/%i%9$N2r<a!&I=<((B
- $B7Q>5!&%]%j%b%U%#%:%`$N<B8=!J%a%=%C%I8F$S=P$7$G=PMh>e$,$C$F$k$C$F$3$H$@$1$I!K(B

$B""(B 1.8 $B$^$@$G$-$F$J$$$3$H(B

$B$H$j$"$($:!"$^$@$?$C$/$5$s$"$j$^$9!#(B

- $B%P%$%H%3!<%IH>J,$/$i$$(B?
- $B%9%l%C%I(B
- $B$&$4$+$J$$%M%$%F%#%V%a%=%C%I$,$4$m$4$m(B
- $B%M%$%F%#%V%a%=%C%I$N$b(B?$B$C$H4JC1$JDI2C(B
- jar $B%"!<%+%$%V$+$iD>@\%/%i%9$r%m!<%I(B
- $B40`z$J%3!<%I!J%P%0$,7k9=$"$j$=$&!K(B
- $BB.$5!J$*$;!<!&!&!&!K(B
- $B%F%9%H!J$I!<$d$C$F:n$l$P$$$$$s$@!"$3$s$J$b$N$K!K(B
- $B$9$F$-$JL>A0!J(BRava $B$O$+$C$3$o$k$$$>!K(B
- $B$^$@$^$@$"$j$=$&(B

$B""(B 1.9 $B$*$b$&$3$H(B

Ruby $B$d$C$Q$9$4$$$o$!!#0l=54V!"<B<A=5Kv(B3$BF|4V$@$1$G$3$l$@$1$G$-$A$c$&$s(B
$B$@$b$s$J$!!#(B

$B$^$8$a$JOC!"$3$l$G(BVM$B$N%J%K$,8&5f$G$-$k$s$8$c$J$$$+$H$b$/$m$s$G$^$9!#$H(B
$B$j$"$($:!"MhG/$N;E;v$@$1$l$I!"$=$l$O!#(B

$B$^$!!"%8%g!<%/$C$F$3$H$G0l$D!#(B

$BL>A0!#(BJRuby $B$N8~$3$&$rD%$C$F!"(BRJava $B$C$F$7$?$+$C$?$s$@$1$l$I!"4{$K!"(Brjava
, remote java $B$C$F$$$&%f!<%F%#%j%F%#$,$"$k$=$&$GCGG0!#$H$j$"$($:(B Rava$B!#(B
$B$J$s$H$J$/!"%7%`%7%F%#!<$N?7J9$r;W$$=P$7$^$;$s$+!)(B

Ruby $B$H(B Java $B!"$$$C$?$j$-$?$j$7$F%=!<%9=q$$$F$k$H!"$@$a$C$9$M!#$H$j$"$((B
$B$:(B Java $B$,$+$1$J$/$J$C$?!#J8;zNs$r(B''$B$G0O$s$G$_$?$j!"(B';' $B$rK:$l$F$_$?$j!#(B

$B@[$$%=!<%9$G$9$,!"2~A1E@$J$I$"$l$P!"$465<x$$$?$@$1$l$P9,$$$G$9!#(B


$B"#(B 2 $B$l$s$i$/$5$-(B

$B$40U8+!"$4MWK>!"$46l>p$O$3$A$i$N%a!<%k%"%I%l%9$X$*4j$$$7$^$9!#(B

$B!!(Bsasada@namikilab.tuat.ac.jp

$B$^$?!"0l;~G[I[@h$O(B

$B!!(Bhttp://www.namikilab.tuat.ac.jp/~sasada/

$B$N$I$3$+$K$"$k$H;W$$$^$9!#(B


$B$J$*!"K\%W%m%0%i%`$O!"JBLZ8&5f<<$H$O!"$"$^$j4X78$,$"$j$^$;$s!#(B

$B$5$5$@$N<qL#$G$9!#(B

$B$@$1$I!">e$K=R$Y$?$H$*$j!"8&5f$GMxMQ$9$k$+$b$7$l$^$;$s!#(B

$B$7$J$$$+$b$7$l$^$;$s!#(B


