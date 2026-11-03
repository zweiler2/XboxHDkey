CC      ?= cc
CFLAGS  ?= -std=gnu99 -Wall -Wextra -Werror
SRCDIR   = src
INCDIR   = include
OBJDIR   = build
TARGET   = xboxhdkey

SRCS = $(SRCDIR)/apt.c $(SRCDIR)/sgio.c $(SRCDIR)/sysfs.c \
       $(SRCDIR)/BootEEPROM.c $(SRCDIR)/BootHddKey.c \
       $(SRCDIR)/rc4.c $(SRCDIR)/sha1.c $(SRCDIR)/main.c
OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -I$(INCDIR) -c -o $@ $<

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	rm -rf $(OBJDIR) $(TARGET)
