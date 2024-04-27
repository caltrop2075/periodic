#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
#===============================================================================
BEGIN {

   blk="\033[0;2;30m"               # dim
   red="\033[0;2;31m"
   grn="\033[0;2;32m"
   yel="\033[0;2;33m"
   blu="\033[0;2;34m"
   mag="\033[0;2;35m"
   cyn="\033[0;2;36m"
   wht="\033[0;2;37m"

   Blk="\033[0;30m"                 # normal
   Red="\033[0;31m"
   Grn="\033[0;32m"
   Yel="\033[0;33m"
   Blu="\033[0;34m"
   Mag="\033[0;35m"
   Cyn="\033[0;36m"
   Wht="\033[0;37m"

   BLK="\033[0;1;30m"               # bold         some terminals
   RED="\033[0;1;31m"
   GRN="\033[0;1;32m"
   YEL="\033[0;1;33m"
   BLU="\033[0;1;34m"
   MAG="\033[0;1;35m"
   CYN="\033[0;1;36m"
   WHT="\033[0;1;37m"

   nrm="\033[0m"                    # 0 add these after colors

   FS=","                           # csv file
   tgt=tolower(q)                   # to lower for compare
   d=""                             # divider
   for(i=0;i<117;i++)
      d=d"-"
 }
#===============================================================================
{
   if(NR==1)
      n=split($0,ary)               # header array
   else
   {
      str=tolower($2)               # to lower for compare
      if(match(str,tgt))
      {
         fx_d()
         for(i=1;i<=NF;i++)
         {
            switch(i)               # colour hiliting
            {
               case 1:              # atom-n
               case 2:              # name
               case 3:              # symbol
               case 4:              # mass
                  printf(Wht);break
               case 10:             # phase
               case 11:             # radioactive
               case 12:             # natural
               case 13:             # metal
               case 14:             # -
               case 15:             # -
               case 16:             # type
                  printf(Grn);break
               default :
                  printf(grn)
            }
            printf("%11s: ",ary[i]) # print header
            switch($i)              # print data & symbol substitution
            {
               case "artificial":printf("%-14s","◇");break
               case "gas"       :printf("%-14s","○");break
               case "liquid"    :printf("%-14s","◒");break
               case "solid"     :printf("%-14s","●");break
               case "yes"       :printf("%-14s","▲");break
               default          :printf("%-12s",$i)
            }
            if(i%4==0)              # column control
               printf("\n")
            else
               printf("   ")
         }
         if(i%4==0)
            printf("\n")
         system("sleep 0.2")        # display delay
      }
   }
}
#===============================================================================
END {
   fx_d()
}
#===============================================================================
# functions
#-------------------------------------------------------------------------------
function fx_d()                     # print divider
{
   printf(Red"%s\n"nrm,d)
}
#===============================================================================
