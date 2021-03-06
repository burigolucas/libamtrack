basic_plots README

0. Rationale

This example was written to provide easy way of generating data
which could be later used in plots. It cover most basic units
of libamtrack library: ER, RDD models, LET and CSDA range calculations.
Source file AT_plot.c can be compiled and linked to libamtrack library
to produce executable file AT_plot.exe. This executable file
can be used to generate plots data, can be steered using command line switches.

Lines starting with "$" character are commands to be executed by reader of this tutorial.

1. Compilation

Our example assume that compiled library is in lib folder. Compilation
is done using Makefile provided in current directory.
First step is to adjust operating system (Linux or Windows) in the Makefile in current directory.

To adjust PATH variable in Windows (which keeps track of the directories
containing executable files that can be run without providing full path), 
run windows command line shell (cmd.exe) and use following command:

$ path %path%;"C:\Program Files\MinGW\bin"
$ path %path%;"C:\Program Files\GnuWin32\bin"

These two command should append directories containing make.exe and gcc.exe to the PATH variable. 
This trick will work only for one cmd session.

Compile:

$ make all

After this step two files should be generated: AT_plot.o (not needed later) and AT_plot.exe.
Compilation schema is following:

AT_plot.c + libamtrack header files (*.h) + gsl header files (*.h) ---(compiling)---->  AT_plot.o 
AT_plot.o + libamtrack library (*.dll or *.so) + gsl libraries (*.dll or *.so) ---(linking)---->  AT_plot.exe

You can also compile against static version of the library using command:

$ make static

2. Run

When you will have AT_plot.exe file and want to run it under Windows, copy to the same
directory as .exe file all libraries (3 dll files for GSL and libamtrack). 
Under Linux, adjust LD_LIBRARY_PATH variable:

$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../../lib

In case of static compilation you do not need to adjust LD_LIBRARY_PATH variable,
neither copy libamtrack dll files to the same directory.

First let us try to run without any switches:

$ ./AT_plot.exe
Please specify plottype using -t (--plottype) option
Usage: ./AT_plot.exe --plottype PLOTTYPE [ --modeltype MODELTYPE --submodeltype SUBMODELTYPE --xmin XMIN --xmax XMAX --xlogscale --npoints NPOINTS --particle PARTICLE]
Usage (short): ./AT_plot.exe -t PLOTTYPE [ -s MODELTYPE -y SUBMODELTYPE -n XMIN -x XMAX -l -m NPOINTS -p PARTICLE]
Plottypes supported: ER RDD LET CSDArange

We will see short usage summary. There is one main mandatory switch: plottype. Let us check LET:

$ ./AT_plot.exe -t LET
particle not set, setting default value 12C
xmin not set, setting default value 0.1 [MeV]
xmax not set, setting default value 500 [MeV]
npoints not set, setting default value 10
#LET vs primary ion energy
#particle: 12C (code: 6012)
#E[MeV] LET[MeV/cm2g]
0.1 7490.09
55.6444 411.661
111.189 242.577
166.733 182.175
222.278 151.218
277.822 132.311
333.367 119.625
388.911 110.616
444.456 103.886
500 98.748

Now let us come to more complicated example: RDD.

$ ./AT_plot.exe -t RDD
Specify RDD model using --modeltype (-s) option
1 - Simple step test function
2 - Katz' point target RDD
3 - Geiss' RDD [Geiss et al., 1998]
4 - Site RDD, as defined in [Edmund et al., 2007]
5 - Cucinotta, as defined in [Cucinotta et al. 1997]
6 - Katz Extended Target
7 - Cucinotta Extended Target

As we see now it is not enough to provide plottype, we also need
to specify which RDD do we want to use. Let us play with Katz point target:

$ ./AT_plot.exe -t RDD --modeltype 2
Specify ER model using --submodeltype (-y) option
1 - simple test ER model
2 - Butts & Katz' ER model (linear)
3 - Waligorski's ER model (power-law wmax)
4 - Geiss' ER model (power-law E)
5 - Scholz' ER model (power-law E)
6 - Edmund' ER model (power-law wmax)
7 - Tabata  ER model


I've written option in long manner (--modeltype instead of -s), but
both types of switch providing method: long and short are equivalent.
RDD is complicated example as I said, what we see now is that ER is missing.
Let us choose 4:

$ ./AT_plot.exe -t RDD --modeltype 2 -y 4
particle not set, setting default value 12C
xmin not set, setting default value 1e-12 [m]
xmax not set, setting default value 1e-06 [m]
npoints not set, setting default value 10
#ER: Geiss' ER model (power-law E)
#RDD: Katz' point target RDD
# RDD parameter 0 : r_min_m = 1e-10
# RDD parameter 1 : d_min_Gy = 1e-10
#particle: 12C (code: 6012)
#r[m] D[Gy]
Incompatible ER model (Geiss' ER model (power-law E)) used with RDD model (Katz' point target RDD)


Unfortunately Katz point RDD is well defined only for
few electron range models, so let us take different choice:

$ ./AT_plot.exe -t RDD --modeltype 2 -y 3
particle not set, setting default value 12C
xmin not set, setting default value 1e-12 [m]
xmax not set, setting default value 1e-06 [m]
npoints not set, setting default value 10
#ER: Waligorski's ER model (power-law wmax)
#RDD: Katz' point target RDD
# RDD parameter 0 : r_min_m = 1e-10
# RDD parameter 1 : d_min_Gy = 1e-10
#particle: 12C (code: 6012)
#r[m] D[Gy]
1e-12 0
1.11112e-07 2.08884
2.22223e-07 0.522147
3.33334e-07 0.232036
4.44445e-07 0.130503
5.55556e-07 0.0835112
6.66667e-07 0.0579863
7.77778e-07 0.0425966
8.88889e-07 0.0326088
1e-06 0.0257616

Now we can come back to usage summary:

$ ./AT_plot.exe 
Please specify plottype using -t (--plottype) option
Usage: ./AT_plot.exe --plottype PLOTTYPE [ --modeltype MODELTYPE --submodeltype SUBMODELTYPE --xmin XMIN --xmax XMAX --xlogscale --npoints NPOINTS --particle PARTICLE]
Usage (short): ./AT_plot.exe -t PLOTTYPE [ -s MODELTYPE -y SUBMODELTYPE -n XMIN -x XMAX -l -m NPOINTS -p PARTICLE]
Plottypes supported: ER RDD LET CSDArange

In the options list we see also possibility of specyfing range on X axis, axis type (linear or logarythmic),
number of points and particle type. Let us use this options:

$ ./AT_plot.exe -t RDD --modeltype 2 -y 3 --xmin 1e-10 --xmax 1e-5 --xlogscale --npoints 20 --particle 4He
#ER: Waligorski's ER model (power-law wmax)
#RDD: Katz' point target RDD
# RDD parameter 0 : r_min_m = 1e-10
# RDD parameter 1 : d_min_Gy = 1e-10
#particle: 4He (code: 2004)
#r[m] D[Gy]
1e-10 286577
1.83298e-10 85295.5
3.35982e-10 25386.9
6.15848e-10 7556.04
1.12884e-09 2248.94
2.06914e-09 669.363
3.79269e-09 199.226
6.95193e-09 59.2963
1.27427e-08 17.6486
2.33572e-08 5.25276
4.28133e-08 1.56337
7.8476e-08 0.465295
1.43845e-07 0.138477
2.63665e-07 0.0412099
4.83293e-07 0.0122624
8.85867e-07 0.00364798
1.62378e-06 0.00108482
2.97635e-06 0.000322365
5.45559e-06 9.56654e-05
1e-05 2.83192e-05

Not relevant messages are printed to stderr, so in order to save results to the
file for later printing (ex. with gnuplot we can use following trick):

$ ./AT_plot.exe -t RDD --modeltype 2 -y 3 > file.dat
particle not set, setting default value 12C
xmin not set, setting default value 1e-12 [m]
xmax not set, setting default value 1e-06 [m]
npoints not set, setting default value 10

$ cat file.dat 
#ER: Waligorski's ER model (power-law wmax)
#RDD: Katz' point target RDD
# RDD parameter 0 : r_min_m = 1e-10
# RDD parameter 1 : d_min_Gy = 1e-10
#particle: 12C (code: 6012)
#r[m] D[Gy]
1e-12 0
1.11112e-07 2.08884
2.22223e-07 0.522147
3.33334e-07 0.232036
4.44445e-07 0.130503
5.55556e-07 0.0835112
6.66667e-07 0.0579863
7.77778e-07 0.0425966
8.88889e-07 0.0326088
1e-06 0.0257616
