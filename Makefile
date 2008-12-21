SRC = core/internal.c core/objmodel.c core/pn-gram.c core/pn-scan.c core/potion.c core/string.c
OBJ = ${SRC:.c=.o}

PREFIX = /usr/local
CC = gcc
CFLAGS = -O -Wall -DICACHE -DMCACHE
INCS = -Icore
LIBS =

# pre-processors
LEMON = lemon
RAGEL = ragel

all: potion

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} -o $@ $<

core/pn-scan.c: core/pn-scan.rl
	@echo RAGEL $<
	@${RAGEL} $< -C -o $@

core/pn-gram.c: core/pn-gram.y
	@echo LEMON $<
	@${LEMON} $<

potion: ${OBJ}
	${CC} ${CFLAGS} ${OBJ} -o potion

todo:
	@grep -rI TODO core

clean:
	@echo cleaning
	@rm -f potion ${OBJ} core/pn-gram.c core/pn-gram.h core/pn-gram.out core/pn-scan.c

.PHONY: all clean
