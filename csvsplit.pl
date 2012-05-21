#!/usr/bin/perl -- -*- perl -*-
# Perl script by Reini Urban (c) 2012
use utf8;
use strict;
# https://docs.google.com/spreadsheet/ccc?key=0AmdgVGA_rtJzdHhmRmRtejhteGs1V0NiWVJhTWJOUlE
# save as csv

open my $f,'<','Cannes 2012 - Películas%2FFilms.csv' or die;
my (@critics, $section, $tmp, @r, $t);
while (<$f>) {
  if (/^COMPETENCIA OFICIAL,/) {
    $tmp =~ s/\n/ /g;
    $tmp =~ s/"//g;
    $tmp =~ s/Alejandro  G. Calvo/Alejandro G. Calvo/;
    @critics = split /,/, $tmp;
    shift @critics;
    shift @critics;
    $section = 'Competition';
    next;
  }
  $tmp .= $_ if !@critics and $_ !~ /^,,,/;
  next unless @critics;
  if (/^(\w[^\d,]+),,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/) { # next section
    $section = $1;
    if ($section =~ /UN CERTAIN REGARD/) {
      $section = 'Un Certain Regard';
    } elsif ($section =~ /SEMANA DE LA/) {
      $section = 'Semaine';
    } elsif ($section =~ /QUINCENA DE LOS/) {
      $section = 'Quinzaine';
    } elsif ($section =~ /MEDIANOCHE/) {
      $section = 'Midnight';
    } else {
      $section = join(' ',map{uc(substr($_,0,1)).lc(substr($_,1))} split(' ',$section));
    }
    next;
  }
  if (/^"[^,"]+$/) {
    my $s = <$f>;
    chomp;
    $_ .= " ".$s;
    if (/^"(.+)",(.+)$/) { 
      $t = $1;
      $_ = $2;
    }
    @r = split /,/, $_;
  } else {
    chomp;
    @r = split /,/, $_;
    $t = $r[0];
    $t =~ s/"//g;
    shift @r;
  }
  my $avg = shift @r;
  next if $avg eq '#DIV/0!';
  next unless $t;
  $t =~ s/^(.+) (\(.+\))/"$1" $2/;
  print "\n$t [$section]\n";
  for (my $i=0; $i<@r; $i++) {
    print "$critics[$i] $r[$i]\n" if $r[$i];
  }
}
