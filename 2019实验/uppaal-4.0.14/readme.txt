README for UPPAAL 4.0.14
Uppsala University and Aalborg University.
Copyright (c) 1995 - 2010. All right reserved.

October, 2010

1. Introduction
2. Installation
3. New features in this release
4. Known issues in this release
5. Commercial license agreement
6. Non-commercial license agreement

1. Introduction
===============

This is the 4.0.14 release of UPPAAL 4.0 -- a model checker
for timed automata.

Note that UPPAAL is free for non-profit applications but we want all
users to fill in a license agreement. This can be done online on the
web site http://www.uppaal.com/ or by sending in the form attached
below.

Please refer to the commercial license agreement for commercial uses.

This product includes the libxml2 library which is copyrighted as
follows: "Copyright (C) 1998-2006 Daniel Veillard.  All Rights
Reserved."

2. Installation 
===============

2.1 Microsoft Windows & GNU/Linux
---------------------------------

To install, unzip the zip-file. This should create the directory
uppaal-4.0.14 containing at least the files uppaal, uppaal.jar, and the
directories lib, man, bin-Linux, bin-Win32, lib, man and demo. The
bin-directories should all contain the two files verifyta(.exe) and
server(.exe) plus some additional files, depending on the
platform. The demo-directory should contain some demo files with
suffixes .xml and .q.

Note that UPPAAL will not run without Java 2 installed on the host
system. Java 2 for SunOS, Windows95/98/Me/NT/2000/XP, and Linux can be
downloaded from http://java.sun.com.

The present version of UPPAAL does no longer support versions 1.1,
1.2, 1.3 and 1.4 of the Java Runtime Environment (JRE). You need at
least JRE 5, and we strongly recommend using the most recent version
available for your platform. Compatibility problems with Windows Vista
have been reported, however it is currently believed that these
problems are caused by the JRE. Please double check that you use the
latest JRE for Windows Vista before reporting any problems with
running Uppaal on Windows Vista.

To run UPPAAL on Linux systems run the script named 'uppaal'. To run
on Windows 95/98/Me/NT/2000/XP systems double click the file
uppaal.jar.

2.2 Apple Mac OS X
------------------

To install Uppaal on Mac OS X, double-click the disk image to open it
and then drag and drop the Uppaal.app application to the /Applications folder.

Make sure that Java 6 or above is activated (see the FAQ).

To run Uppaal, double-click the Uppaal.app application.


3. New features and changes
===========================

See the release notes at http://www.uppaal.com/.

4. Known issues in this release
===============================

We now have a bug management system available at
http://www.uppaal.com/. Please use this system to obtain a list of
known problems.


5. Commercial license agreement
===============================

UP4ALL International AB hereby offers us (the licensee) an industrial licence
to use the model-checking tool UPPAAL. We understand that UPPAAL includes the
following programs: uppaal.jar, server, socketserver, verifyta, and uppaal.
We agree on the following:

1. The license is a one year floating license of the UPPAAL tool "as is" without
   expressed or implied warranty.

2. We are free to upgrade to newer releases of UPPAAL during the time period that
   this agreement is valid.

3. UP4ALL International AB neither has any responsibility for the correctness
   of systems verified using UPPAAL, nor for the correctness of UPPAAL itself.

4. We will never distribute, modify, or reverse-engineer (such as disassemble)
   any part of UPPAAL.

5. Support requests are handled as queries submitted to the UPPAAL mailing list
   and answered by other users of the UPPAAL tool.

6. UP4ALL International AB offers training, support, priority bug fixes, and
   further tool customization for a cost of EUR 100,- per hour (current rate,
   may be subject to change).

7. UPPAAL International AB may use our company name and logo to announce that
   we use the UPPAAL tool, e.g. on the UPPAAL web page.


6. Non-commercial license agreement
===================================

Please read the license agreement carefully, fill in the form, and
send it to 

  Wang Yi
  Dept. of Information Technology
  Uppsala University
  Box 325
  751 05 Uppsala, Sweden

The text of the agreement follows:
                                              
We (the licensee) understand that UPPAAL includes the programs:
uppaal.jar, server, socketserver, verifyta, and uppaal and that
they are supplied "as is", without expressed or implied warranty.
 We agree on the following:

1. You (the licensers) do not have any obligation to provide any
   maintenance or consulting help with respect to UPPAAL. 

2. You neither have any responsibility for the correctness of systems
   verified using UPPAAL, nor for the correctness of UPPAAL itself.

3. We will never distribute, modify, or reverse-engineer (such
   as disassemble) any part of the UPPAAL code (i.e. the source
   code and the object code) without a written permission of
   Gerd Behrmann (Aalborg University), Kim G Larsen (Aalborg
   University), Alexandre David (Aalborg University), Paul
   Petterson (Uppsala University), or Wang Yi (Uppsala University).
   
4. We will only use UPPAAL for non-profit research purposes. This
   implies that neither UPPAAL nor any part of its code should be used
   or modified for any commercial software product.

In the event that you should release new versions of UPPAAL to us, we
agree that they will also fall under all of these terms.

