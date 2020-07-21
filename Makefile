.PHONY: all

PROGRAMS = mixcase
all: $(patsubst %,%.od,$(PROGRAMS))

.SECONDARY:

%.od: BASE=$(basename $@)
%.od: %.raw
	od -t u1 $< >| $@

%.raw: %.o
	ld65 -t none -o $@ $^

%.o %.list: %.s
	ca65 --listing $(BASE).list $(BASE).s

.PHONY: clean
clean:
	rm -f *.o *.list *.od *.raw
