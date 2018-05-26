PFUNIT = /Users/osdnk/pfu
F90_VENDOR = Intel
F90=ifort

include $(PFUNIT)/include/base.mk

FFLAGS += -std08 -warn all  -funroll-loops -pedantic -I$(PFUNIT)/mod
LIBS = $(PFUNIT)/lib/libpfunit$(LIB_EXT)

PFS = $(wildcard *.pf)
OBJS = $(PFS:.pf=.o)

%.F90: %.pf
	$(PFUNIT)/bin/pFUnitParser.py $< $@

%.o: %.F90
	$(F90) $(FFLAGS) -c $<

test: testSuites.inc mult.o $(OBJS)
	$(F90) -o $@ -I$(PFUNIT)/mod -I$(PFUNIT)/include \
		$(PFUNIT)/include/driver.F90 \
		./*$(OBJ_EXT) $(LIBS) $(FFLAGS)

clean:
	find . -name "*genmod*" -type f

default:
	$(F90) -std08 -D -fpp multWithDot.f90 main.f90 -o main
