TARGET := project
SRC := src
INC := include
SRCS := $(shell find $(SRC) -type f -name "*.c")
OBJS := $(patsubst %.c,%.o,$(SRCS))
DEPS := $(patsubst %.c,%.d,$(SRCS))

CC := gcc
LD := ld
CFLAGS := -std=c99 -pedantic -fvisibility=hidden -I$(INC)
CFLAGS += -Wall -Werror -Wextra -O0 -g
CFLAGS += -MMD -MP

.PHONY: all
all:: $(TARGET)

-include $(DEPS)

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -rf $(TARGET)
	rm -rf $(OBJS)
	rm -rf $(DEPS)

.PHONY: tags cscope
all: tags cscope

cscope.files: $(SRCS)
	$(shell find $(SRC) $(INC) -type f -name "*.[chS]") > $@

tags: cscope.files
	@ctags -R --exclude=@.ctagsignore -L $^

cscope: cscope.files
	@cscope -bqki $^
