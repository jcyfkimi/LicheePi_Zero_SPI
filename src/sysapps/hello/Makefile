
CROSS = $(SOURCETOOLCHAIN)

CC = $(CROSS)gcc
AR = $(CROSS)ar
LD = $(CROSS)ld
STRIP = $(CROSS)strip
STRIPCMD = $(STRIP) --remove-section=.note --remove-section=.comment
INSTALL = @install
RM = @rm
CP = @cp
CHMOD = @chmod

LDFLAGS = -s
LIBFLAGS = -lpthread -lresolv

CFLAGS += -O2 -I./include -I$(PROJECT_ROOT)/src/kernel/linux/include

BIN = hello

SRCS = $(BIN).c
OBJS = $(SRCS:.c=.o)

all: $(BIN) install

$(OBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

$(BIN): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBFLAGS)
	$(STRIPCMD) $@

clean: uninstall
	$(RM) -f $(BIN) *.o *~

install:
	$(INSTALL) -D $(BIN) $(PROJECT_INSTALL)/usr/local/bin/$(BIN)

uninstall:
	$(RM) -f $(PROJECT_INSTALL)/usr/local/bin/$(BIN)




