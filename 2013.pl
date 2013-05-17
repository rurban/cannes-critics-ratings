#!/usr/bin/perl -s
# usage: 2013.pl -u without wget fetch
# no timestamp by server
use File::Copy;
use utf8;
my $url = "http://www.todaslascriticas.com.ar/cannes";
my $c = "Cannes2013.html";
my $bak = "$c.old";
$max = 8;

unless ($u) {
  move $c, $bak;
  print `wget -O $c $url`;
}
END {
  move($bak, $c) if -s $bak and !-s $c;
}

if (-s $c) {
  my $diff = -f $bak ? `diff -bu $c $bak` : "";
  if ($u or $diff) {
    warn "process updates";
    if (-f $bak) {
      open $cf, ">$c.text";
      select $cf;
    }
    $ch = readhtml($c);
    close $cf;
    if (-f $bak) {
      open $bf, ">$bak.text";
      select $bf;
      $bh = readhtml($bak);
      close $bf;
      select *STDOUT;
      my $cmd = "diff -bu $bak.text $c.text";
      print "$cmd\n";
      print `$cmd`;
    }
  } else {
    warn "no updates";
    unlink $bak;
  }
} else {
  warn "empty response";
  move $bak, $c;
}

sub readhtml {
  my $c = shift;
  open $fh, $c or die;
  my (@c, @r, %t, @t, $t);
  while ($_ = <$fh>) {
    s/\r\n$//;
    if (m{<th class="text-center">Roger Koza</th>}) {
      s/^\s+<th//;
      s/<\/th>\s+<\/tr>//;
      @c = grep { 
	s{ class=".+?">}{};
      } split("</th><th", $_);
      next;
    }
    if (m{^\s+<td>([A-Z0-9ÑÉÈÂÀÇ][A-Z\&\'\wÑÉÈÂÀÇ! ]+?)</td>$}u) {
      $t = $1;
      push @t, $t;
      next;
    }
    if (m{^\s+<td.*</tr>$}) {
      s/^\s+<td//;
      s/<\/td>\s+<\/tr>//;
      @r = grep { 
	s{( class=".+?")?>}{};
      } split("</td><td", $_);
      if (@c == @r) {
	my $i = 0;
	for my $c (@c) {
	  if ($r[$i]) {
	    $t{$t}->{$c} = $r[$i];
	    $t{$t}->{_} = 1;
	  }
	  $i++;
	}
      }
      next;
    }
  }
  print "\n";
  for my $t (@t) {
    if ($t{$t}->{_}) {
      my $n = 0;
      for my $c (@c) { $n++ if $t{$t}->{$c}; }
      print "$t  ($n)\n\n";
      for my $c (@c) {
	if ($n > $max or $t{$t}->{$c} ne '') {
	  printf("%-22s%s\n", $c, $t{$t}->{$c});
	}
      }
      print "\n";
    }
  }
}

sub update {
  my $diff = shift;
}
