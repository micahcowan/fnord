.PHONY: all

PROGRAMS = mixcase
PROGRAMS_od = $(patsubst %,%.od,$(PROGRAMS))
PROGRAMS_add = $(patsubst %,%.add,$(PROGRAMS))
all: $(PROGRAMS_add)

.SECONDARY:

%.add: %.od disk.dsk
	dos33 -y -a 0x300 disk.dsk BSAVE $(basename $@).raw $(shell echo $(basename $@) | tr '[:lower:]' '[:upper:]')
	touch $@

disk.dsk: empty.dsk
	cp empty.dsk disk.dsk

%.od:
%.od: %.raw
	od -t u1 $< >| $@

%.raw: %.o
	ld65 -t none -o $@ $^

%.o %.list: %.s
	ca65 --listing $(basename $@).list $(basename $@).s

.PHONY: clean
clean:
	rm -f *.add *.o *.list *.od *.raw disk.dsk
