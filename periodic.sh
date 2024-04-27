#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# periodic table from csv using regex (not case sensitive) find
# prints row by row of data colour hilited
# or sorted quick lists
#
# bash & awk skills
# using escape color, case & switch, various loops, functions
# and using basic regular expressions
#
# 2023-07-15 initial program completed
# 2023-07-16 added sorted quick list, same as pertbl.sh HP48
#
#---------------------------------------------------------------- initialization
source ~/data/global.dat
dat="$HOME/data/periodic_table.csv"
#--------------------------------------------------------------------- functions
fx_help ()
{
   echo
   echo "periodic.sh [-h -l -s -n regex]"
   echo "-h or no opt - help"
   echo "-l           - quick list by #"
   echo "-n           - quick list by name"
   echo "-s           - quick list by symbol"
   echo "regex        - regular expression element name"
   echo
   echo "regex examples:"
   echo "periodic.sh \"iron\"           find Iron"
   echo "periodic.sh \".*ine\"          find all ending in 'ine'"
   echo "periodic.sh \".*ine|iron\"     both the above"
   echo "periodic.sh \"(.*ine)|(iron)\" same as above"
   echo
   echo "more examples:"
   echo "find 3 elements"
   echo "   periodic.sh \"carbon|nitrogen|iron\""
   echo "good example of different phases & metal/nonmetal"
   echo "   periodic.sh \"carbon|nitrogen|silicon|iron|bromine\""
}
#-------------------------------------------------------------------------------
fx_list ()
{
   title-80.sh -t line "Periodic Table Llist - $1"
   printf "$Wht%3s|%-14s|%s$nrm\n" "#" "NAME" "SYMBOL"
   sleep 2
   IFS=","                 # make quick list
   cat "$dat" |
   {                       # need so var can be used in while loop
      c=0
      while read -a ary
      do
         if ((c))          # skip first line, 0
         then
            printf "%3d|%-14s|%s\n" "${ary[0]}" "${ary[1]}" "${ary[2]}"
         fi
         ((c++))
      done > ~/temp/temp.dat
   }
   case $1 in              # quick list sort options
      -l) cat ~/temp/temp.dat;;
      -n) cat ~/temp/temp.dat | sort -t "|" -k 2;;
      -s) cat ~/temp/temp.dat | sort -t "|" -k 3;;
   esac
}
#-------------------------------------------------------------------------------
fx_regex ()
{
   title-80.sh -t line "Periodic Table Lookup\n$1"
   sleep 2
   cat "$dat" | periodic.awk -v q=$1

   f=10
   printf "SYMBOL LEGEND\n"
   printf "%${f}s %s "  "artificial" "◇"
   printf "%${f}s %s "  "gas"        "○"
   printf "%${f}s %s "  "liquid"     "◒"
   printf "%${f}s %s "  "solid"      "●"
   printf "%${f}s %s\n" "yes"        "▲"
}
#------------------------------------------------------------------ main program
if [[ $# == 0 ]]
then
   fx_help
else
   case $1 in
      -h) fx_help;;
      -l) fx_list $1;;
      -n) fx_list $1;;
      -s) fx_list $1;;
      *)  fx_regex "$1";;
   esac
fi
#-------------------------------------------------------------------------------
