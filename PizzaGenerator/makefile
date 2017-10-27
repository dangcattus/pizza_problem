OBJS = main.o
CC = g++
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

all: pizzagen

pizzagen: $(OBJS)
		$(CC) $(LFLAGS) $(OBJS) -o pizzagen

main.o: main.cpp
	g++ -Wall -c main.cpp

clean:
		rm *.o *~ pizzagen
