#!/bin/csh
set step = 1
set maxevents = 19
set firstevent = 0
set i = 0
while ( $firstevent < $maxevents ) #loop em i

set nr1 = `python random_cfg.py`
set nr2 = `python random_cfg.py`
#echo $nr1
#echo $nr2
cd fpmc/
cat > dataQED_WW << EOF
NTNAME      'tmpntuple.ntp'
LHEFILE     'FPMC_gamgamWW_13TeV.lhe'
MAXEV       1000
TYPEPR      'EXC'
TYPINT      'QED'
ECMS        13000.
IPROC       16010
NFLUX       15
NRN1        $nr1
NRN2        $nr2
YJMAX       15.
YJMIN      -15.
PTMIN       0.
IFIT        10
ISOFTM	    1
YWWMIN      0.01
YWWMAX      0.2
Q2WWMN      0.0
Q2WWMX      4.0
EOF
./fpmc-hepmc --cfg dataQED_WW --comenergy 13000 --fileout FPMC_WW_13TeV.hepmc --nevents 20000 > out_FPMC_WW_13TeV.txt
rm dataQED_WW

scp FPMC_WW_13TeV.hepmc mthiel@uerjpowerp100.cern.ch:/storage2/mthiel/gen_fpmc_ww_exc/FPMC_WW_13TeV_${i}_.hepmc

rm FPMC_WW_13TeV.hepmc

@ firstevent =  $i * $step
@ i++

cd ..

end

cd fpmc/
scp out_FPMC_WW_13TeV.txt  mthiel@uerjpowerp100.cern.ch:/storage2/mthiel/gen_fpmc_ww_exc/
cd ..
