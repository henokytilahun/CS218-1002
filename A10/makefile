# CS 218 Assignment #10
# Simple make file for asst #10

OBJS	= torus.o a10procs.o
ASM	= yasm -g dwarf2 -f elf64
CC	= g++ -g -std=c++11 

all: torus

torus.o: torus.cpp
	$(CC) -c torus.cpp

a10procs.o: a10procs.asm 
	$(ASM) a10procs.asm -l a10procs.lst

torus: $(OBJS)
	$(CC) -no-pie -o torus $(OBJS) -lglut -lGLU -lGL -lm

# -----
# clean by removing object files.

clean:
	rm  $(OBJS)
	rm  a10procs.lst

